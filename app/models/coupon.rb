class Coupon < ActiveRecord::Base
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





