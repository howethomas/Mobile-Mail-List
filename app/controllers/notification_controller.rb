class NotificationController < ApplicationController
  def notify
    subs = Subscriber.find(:all)
    add_app_info("Sending message to all subscribers")
    for s in subs do
      send_text_message(params[:msg], s.callerid)      
    end
    flash[:notice] = "Message sent"
    redirect_to :back
  end
  def index
    
  end

end
