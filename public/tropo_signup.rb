begin
  require 'rubygems'
  require 'restclient'
  require 'URI'
  require 'net/http'
  
  SITE_ID = 1
  
  def is_phone callerID
    # Wow, is this ugly.  This is a regex expression that will tell us if the call is coming from a North American phone
    # number. It will match true if it does, otherwise not. 
    magic = /^(1\s*[-\/\.]?)?(\((\d{3})\)|(\d{3}))\s*[-\/\.]?\s*(\d{3})\s*[-\/\.]?\s*(\d{4})\s*(([xX]|[eE][xX][tT])\.?\s*(\d+))*$/
    magic === callerID
  end
  
  answer
  wait 1000
  
  # If this is a voice call, we can use voice to communicate. Otherwise, we will just use text.
  if is_phone($currentCall.callerID)
    res = Net::HTTP.post_form(URI.parse('http://mobilemaillist.heroku.com/subscribers.xml'), {"subscriber[site_id]" => SITE_ID.to_s, "subscriber[callerid]" => $currentCall.callerID})
    say "Thanks for signing up for our preferred customer program. You will receive exclusive savings offers to your mobile 
      phone, and receive ten percent off all future purchases. Thanks for shopping at William Hows hat store. Good bye and good luck."
  else
    say "Hey, chatter. Thanks for signing up for our preferred customer program. You will receive exclusive savings offers to your mobile 
      phone, and receive ten percent off all future purchases. Thanks for shopping at William Hows hat store."
      
    result = ask "Need a phone number to register. Hit me"
    say "Thanks for that. #{result} will be registered."
  end
  hangup

rescue Exception => e
  log e.inspect
  log e.backtrace
end
