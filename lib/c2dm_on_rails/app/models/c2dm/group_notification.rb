require 'net/http'
require 'uri'

class C2dm::GroupNotification < C2dm::Base
  self.table_name= "c2dm_group_notifications"
  
  include ::ActionView::Helpers::TextHelper
  extend ::ActionView::Helpers::TextHelper
  serialize :data
  
  belongs_to :group, :class_name => 'C2dm::Group'
  has_many   :device_groupings, :class_name => 'C2dm::DeviceGrouping', :through => :group
  
  validates_presence_of :group_id
  
  def devices
    self.group.devices
  end

end
