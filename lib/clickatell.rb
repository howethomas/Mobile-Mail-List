# Clickatell Message Sending Class
# Pretty basic, but does what we want
# (including addressbook functionality)
# Author   : Mike Grice <mike@mikegrice.com>
# Version  : 1.0
# Date     : February 01 2006
# Comments : Needs re-implementing to use https.  So little time...

class Clickatell
  require 'net/http' 
  require 'uri' 
  require 'cgi'
  require 'yaml'

  def initialize(from, to, message)
    @mess    = CGI::escape(message)
    login    = YAML::load(File.open('login.yml'))
    @username = login['username']
    @password = login['password']
    @api_id   = login['api_id']
    @envelope = "from=" + from + "&to=" + to + "&text=" + @mess
  end

  def fetch(uri_str, limit=10) 
    fail 'http redirect too deep' if limit.zero? 
    response = Net::HTTP.get_response(URI.parse(uri_str)) 
    case response 
    when Net::HTTPSuccess 
      response 
    when Net::HTTPRedirection 
      fetch(response['location'], limit-1) 
    else 
      response.error! 
    end 
  end 
  
  def login!
    @uri_base = 'http://api.clickatell.com/http/'
    @credentials = 'user=' + @username + '&password=' + @password + '&api_id=' + @api_id
    auth_uri = "#{@uri_base}auth?#{@credentials}"
    response = fetch(auth_uri) 
    crap, @sess_id = response.body.split(/: /)
  end
 
  def send!
    post_uri = "#{@uri_base}sendmsg?#{@sess_id}&#{@credentials}&#{@envelope}"
    response = fetch(post_uri)
  
    if response.body =~ /^ID:/
      puts "Message sent OK."
    else
      puts "Message sending failed."
      puts "DEBUG:"
    end
  end

  def convert_number(number)
    if number =~ /^00/
      return number.gsub!(/^00/,'+')
    elsif number =~ /^\+/
      return number
    else
      puts "ERROR: invalid number format #{number}"
      puts "Dying horribly, please use +441234123456 format next time!"
      exit 1
    end
  end

  def if_yes?
    while line = gets
      if line =~ /[Yy]/
        return "yes"
      else
        return nil
      end
    end
  end


end
