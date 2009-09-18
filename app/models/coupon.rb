class Coupon < ActiveRecord::Base
  validates_presence_of :coupon_code, :on => :save, :message => "can't be blank"
  validates_numericality_of :qty, :on => :create, :message => "is not a number"
  validates_uniqueness_of :coupon_code, :on => :save, :message => "must be unique"
  validates_presence_of :name, :on => :create, :message => "can't be blank"
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"
  validates_presence_of :unique, :on => :create, :message => "can't be blank"

  def validate
    unless qty >= 0
      errors.add(:qty, "must not be negative")
    end
  end
  
  def generate_coupon_code
    # I really do hate ruby magic sometimes. 
    # This code takes a range of characters
    code = (0...8).map{65.+(rand(25)).chr}.join
    
    existing_coupon = Coupon.find_by_coupon_code(code)
    while not existing_coupon.nil?
      code = (0...8).map{65.+(rand(25)).chr}.join
      existing_coupon = Coupon.find_by_coupon_code(code)
    end
    self.coupon_code = code
  end
  
  def to_s
    self.name
  end
  
end





