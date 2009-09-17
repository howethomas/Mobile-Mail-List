class Subscriber < ActiveRecord::Base
  validates_presence_of :callerid
  validates_presence_of :site_id
  
  def to_s
    self.callerid
  end
end
