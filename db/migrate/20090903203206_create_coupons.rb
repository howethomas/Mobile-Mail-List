class CreateCoupons < ActiveRecord::Migration
  def self.up
  end

  def self.down
    drop_table :coupons
  end
end
