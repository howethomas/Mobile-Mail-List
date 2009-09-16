class Coupon < ActiveRecord::Base
  def before_create
    code = new_unique_code
    
    while existing_coupon.nil?
      existing_coupon = Coupon.find_by_coupon_code(code)
    self.coupon_code = 
  end
  
  def new_unique_code
    # I really do hate ruby magic sometimes. 
    # This code takes a range of characters
    (0...8).map{65.+(rand(25)).chr}.join
  end
end





