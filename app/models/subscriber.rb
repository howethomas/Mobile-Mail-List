class Subscriber < ActiveRecord::Base
  validates_presence_of :callerid
  validates_uniqueness_of :callerid, :on => :create, :message => "must be unique"
  
  def to_s
    self.callerid
  end
end
