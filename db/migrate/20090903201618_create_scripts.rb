class CreateScripts < ActiveRecord::Migration
  def self.up
    create_table :scripts do |t|
      t.string :script_url
      t.integer :use_count

      t.timestamps
    end
  end

  def self.down
    drop_table :scripts
  end
end
