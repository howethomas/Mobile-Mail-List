class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string :name
      t.integer :script_id

      t.timestamps
    end
  end

  def self.down
    drop_table :sites
  end
end
