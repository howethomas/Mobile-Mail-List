class DashboardController < ApplicationController
  before_filter :login_required
  
  def index
    @subscriber = Subscriber.new 
  end
end
