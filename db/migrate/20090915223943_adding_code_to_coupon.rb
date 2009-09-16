class AddingCodeToCoupon < ActiveRecord::Migration
  def self.up
    add_column :coupons, :coupon_code, :string
  end

  def self.down
    remove_column :coupons, :coupon_code
  end
end
