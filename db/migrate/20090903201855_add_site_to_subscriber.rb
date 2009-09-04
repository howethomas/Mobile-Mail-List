class AddSiteToSubscriber < ActiveRecord::Migration
  def self.up
    add_column :coupons, :site_id, :integer 
    add_column :subscribers, :site_id, :integer
  end

  def self.down
    remove_column :coupons, :site_id
    remove_column :subscribers, :site_id
  end
end
