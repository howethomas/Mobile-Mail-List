# This is the file that is used when somebody calls, texts or chats into the phone number
# specified in the tropo account.  This script is using text to speech (TTS), but could easily
# use an MP3 file for a more professional sound.
# 
# The entire script is wrapped in a begin/end block, because its easier to debug something that
# goes terribly, terribly wrong.  This script is also North American centric. Youll have to write 
# the is_phone function to work with other geographies. 

begin
  require 'rubygems'
  require 'restclient'
  require 'URI'
  require 'net/http'
  
  
# This function figures out if the callerID refers to a valid North American 
# phone number. The magic phrase is ugly, ugly regex. I had a friend send it to me.
#
  def is_phone callerID
    # Wow, is this ugly.  This is a regex expression that will tell us if the call is coming from a North American phone
    # number. It will match true if it does, otherwise not. 
    magic = /^(1\s*[-\/\.]?)?(\((\d{3})\)|(\d{3}))\s*[-\/\.]?\s*(\d{3})\s*[-\/\.]?\s*(\d{4})\s*(([xX]|[eE][xX][tT])\.?\s*(\d+))*$/
    magic === callerID
  end

# Some basic variables for the script.  In a more complex setup, the company name and the
# slogan could be determined at run time.  I wanted to make it simple for this example.
  SITE_ID = 1
  COMPANY_NAME = "Pams Pet Place"
  SLOGAN = "where our hats are nice"
  
# Options for the Tropo calls. Just a bit cleaner to have it up here and away from the actual
# function call. 
  phone_number_options = { "silenceTimeout" => 30.0, :choices => '[10 DIGITS]', :repeat => 3 }  
  yes_no_options = { 
              :choices          => 'yes, no',
              :repeat           => 3,
              :silenceTimeout   => 30.0,
              :onBadChoice      => lambda { say 'I am sorry, I did not understand what you said.' },
              :onTimeout        => lambda { say 'I am sorry.  I did not hear anything.' } }
    
# The main script.  We'll answer the call, then we'll wait 1000 ms before we start.
# The logic is pretty straightfoward.
  answer
  wait 1000
  caller_id = $currentCall.callerID
  log "Accepting a call from #{caller_id}"

  say "Thanks for calling #{COMPANY_NAME} #{SLOGAN}.  We will enter your mobile phone in our database, and you are now eligible to receive a discount off of our products \
      and to receive periodic coupons to your cell phone for special deals."

# So, if this is a valid phone number, lets just use it if thats OK
  if is_phone(caller_id)
    result = ask "Are you calling from the mobile phone you want to register? You must be able to receive text messages to redeem coupons.", yes_no_options
    if result.name == "choice" and result.value == "no" then
      caller_id = nil
    end
  end
  
# if we didn't get a valid phone number, lets ask for it.
  until is_phone(caller_id)
    log "Asking for a valid phone number."
    result=ask 'Please enter the 10 digit U.S. phone number you would like to register.', phone_number_options 
    log result.inspect

    caller_id = result.value
  end

# Post the results to the external site. This is hard coded to the actual site that serves the script.
# This should be made more general in the future.
  log "Adding #{caller_id} to the mobile mail list."
  res = Net::HTTP.post_form(URI.parse('http://mobilemaillist.heroku.com/subscribers.xml'), {"subscriber[site_id]" => SITE_ID.to_s, "subscriber[callerid]" => caller_id})

# Thats it - let's get out of here.
  say "Thanks for signing up for our preferred customer program. You will receive exclusive savings offers to your mobile \
    phone, and receive ten percent off all future purchases. Thanks for shopping at #{COMPANY_NAME}. Good bye!"
  hangup

rescue Exception => e
  log e.inspect
  log e.backtrace
end

