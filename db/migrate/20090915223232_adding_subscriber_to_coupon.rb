class AddingSubscriberToCoupon < ActiveRecord::Migration
  def self.up
    add_column :coupons, :subscriber_id, :integer 
  end

  def self.down
    remove_column :coupons, :subscriber_id
  end
end
