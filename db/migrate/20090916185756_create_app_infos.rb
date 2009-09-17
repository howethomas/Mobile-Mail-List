class CreateAppInfos < ActiveRecord::Migration
  def self.up
    create_table :app_infos do |t|
      t.text :msg
      t.integer :severity
      t.string :controller
      t.integer :site

      t.timestamps
    end
  end

  def self.down
    drop_table :app_infos
  end
end
