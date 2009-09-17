class ApplicationController < ActionController::Base
  include ExceptionNotifiable
  include AuthenticatedSystem
  include RoleRequirementSystem

  helper :all # include all helpers, all the time
  # protect_from_forgery :secret => 'b0a876313f3f9195e9bd01473bc5cd06'
  filter_parameter_logging :password, :password_confirmation
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  
  protected
  
  # Automatically respond with 404 for ActiveRecord::RecordNotFound
  def record_not_found
    render :file => File.join(RAILS_ROOT, 'public', '404.html'), :status => 404
  end
  
  def send_text_message msg, to_number, caller_id = "UNKNOWN"
    to_number = "1"+to_number if to_number[0].chr != "1"
    RAILS_DEFAULT_LOGGER.info("Sending a message to #{to_number}")
    a=Clickatell.new(caller_id,to_number,msg)
    a.login!
    a.send!
  end  
end

