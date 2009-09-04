class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.string :type
      t.integer :subscriber_id
      t.integer :coupon_id

      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
