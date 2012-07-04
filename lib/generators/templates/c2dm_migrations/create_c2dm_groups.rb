class CreateC2dmGroups < ActiveRecord::Migration # :nodoc:
  
  def self.up
    create_table :c2dm_device_groupings do |t|
      t.integer :group_id
      t.integer :device_id
    end
    
    add_index :c2dm_device_groupings, [:device_id], :name => "index_c2dm_device_groupings_on_device_id"
    add_index :c2dm_device_groupings, [:group_id, :device_id], :name => "index_c2dm_device_groupings_on_group_id_and_device_id"
    add_index :c2dm_device_groupings, [:group_id], :name => "index_c2dm_device_groupings_on_group_id"
    
    create_table :c2dm_group_notifications do |t|
      t.integer :group_id, :null => false
      t.string :collapse_key
      t.text :data
      t.boolean :delay_while_idle
      t.integer :time_to_live
      t.datetime :sent_at
      t.timestamps
    end

    add_index :c2dm_group_notifications, [:group_id], :name => "index_c2dm_group_notifications_on_group_id"

    create_table :c2dm_groups do |t|
      t.string :name
      t.datetime :created_at, :null => false
      t.datetime :updated_at, :null => false
      t.integer :app_id
    end
  end

  def self.down
    drop_table :c2dm_device_groupings
    drop_table :c2dm_group_notifications
    drop_table :c2dm_groups
  end
  
end
