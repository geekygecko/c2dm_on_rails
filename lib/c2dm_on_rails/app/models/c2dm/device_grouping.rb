class C2dm::DeviceGrouping < C2dm::Base
  self.table_name= "c2dm_device_groupings"
  
  belongs_to :group, :class_name => 'C2dm::Group'
  belongs_to :device, :class_name => 'C2dm::Device'
  
  validates_presence_of :device_id, :group_id
  validates_uniqueness_of :device_id, :scope => :group_id  
  
end