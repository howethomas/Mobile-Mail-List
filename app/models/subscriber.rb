class Subscriber < ActiveRecord::Base
  validates_presence_of :callerid
  validates_presence_of :site_id
  validates_uniqueness_of :callerid, :on => :create, :message => "must be unique"
  
  def to_s
    self.callerid
  end
end
