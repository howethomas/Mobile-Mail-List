begin
  require 'rubygems'
  require 'restclient'
  require 'URI'
  require 'net/http'
  
  def is_phone callerID
    # Wow, is this ugly.  This is a regex expression that will tell us if the call is coming from a North American phone
    # number. It will match true if it does, otherwise not. 
    magic = /^(1\s*[-\/\.]?)?(\((\d{3})\)|(\d{3}))\s*[-\/\.]?\s*(\d{3})\s*[-\/\.]?\s*(\d{4})\s*(([xX]|[eE][xX][tT])\.?\s*(\d+))*$/
    magic === callerID
  end

  SITE_ID = 1
  COMPANY_NAME = "Hows Hat Store"
  SLOGAN = "where our hats are nice"
  
  phone_number_options = { "silenceTimeout" => 30.0, :choices => '[10 DIGITS]', :repeat => 3 }  
  yes_no_options = { 
              :choices          => 'yes, no',
              :repeat           => 3,
              :silenceTimeout   => 30.0,
              :onBadChoice      => lambda { say 'I am sorry, I did not understand what you said.' },
              :onTimeout        => lambda { say 'I am sorry.  I did not hear anything.' } }
    
  answer
  wait 1000
  caller_id = $currentCall.callerID
  log "Accepting a call from #{caller_id}"

  say "Thanks for calling #{COMPANY_NAME} #{SLOGAN}.  We will enter your mobile phone in our database, and you are now eligible to receive a discount off of our products \
      and to receive periodic coupons to your cell phone for special deals."

  if is_phone(caller_id)
    result = ask "Are you calling from the mobile phone you want to register? You must be able to receive text messages to redeem coupons.", yes_no_options
    if result.name == "choice" and result.value == "no" then
      caller_id = nil
    end
  end
  
  until is_phone(caller_id)
    log "Asking for a valid phone number."
    result=ask 'Please enter the 10 digit U.S. phone number you would like to register.', phone_number_options 
    log result.inspect

    caller_id = result.value
  end

  res = Net::HTTP.post_form(URI.parse('http://mobilemaillist.heroku.com/subscribers.xml'), {"subscriber[site_id]" => SITE_ID.to_s, "subscriber[callerid]" => caller_id})

  say "Thanks for signing up for our preferred customer program. You will receive exclusive savings offers to your mobile \
    phone, and receive ten percent off all future purchases. Thanks for shopping at #{COMPANY_NAME}. Good bye!"
  hangup

rescue Exception => e
  log e.inspect
  log e.backtrace
end
