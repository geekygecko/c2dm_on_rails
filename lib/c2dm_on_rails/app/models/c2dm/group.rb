class C2dm::Group < C2dm::Base
  self.table_name= "c2dm_groups"
  
  has_many   :device_groupings, :class_name => "C2dm::DeviceGrouping", :dependent => :destroy
  has_many   :devices, :class_name => 'C2dm::Device', :through => :device_groupings
  has_many   :group_notifications, :class_name => 'C2dm::GroupNotification'
  has_many   :unsent_group_notifications, :class_name => 'C2dm::GroupNotification', :conditions => 'sent_at is null'
  
  validates_uniqueness_of :name
 
  def send_notifications()
    return if self.unsent_group_notifications.nil?
          
    self.unsent_group_notifications.each do |notification|
      
      devices_exist = false
      
      # api only allows you to send to 1000 devices at once
      self.devices.select("registration_id").find_in_batches(:batch_size => 1000) do |device_batch|
        devices_exist = true unless devices_exist
        registration_ids = device_batch.collect { |device| device.registration_id }
        next if registration_ids.blank?
        logger.info "sending notification #{notification.id} to devices #{registration_ids}"
        response = C2dm::Connection.send_group_notification(notification, registration_ids)
        logger.info "response: #{response[:code]}; #{response.inspect}"
        if response[:code] == 200
          
          notification.sent_at = Time.now
          notification.save!
          
          # TODO figure out how to handle the response correctly
          
          case response[:message]
          when "Error=QuotaExceeded"
            raise C2dm::Errors::QuotaExceeded.new(response[:message])
          when "Error=DeviceQuotaExceeded"
            ex = C2dm::Errors::DeviceQuotaExceeded.new(response[:message])
            logger.warn(ex.message)
          when "Error=InvalidRegistration"
            ex = C2dm::Errors::InvalidRegistration.new(response[:message])
            #logger.warn("#{ex.message}, destroying c2dm_device with id #{noty.device.id}")
            #notification.device.destroy
          when "Error=NotRegistered"
            ex = C2dm::Errors::NotRegistered.new(response[:message])
            logger.warn("#{ex.message}, destroying c2dm_device with id #{noty.device.id}")
            noty.device.destroy
          when "Error=MessageTooBig"
            ex = C2dm::Errors::MessageTooBig.new(response[:message])
            logger.warn(ex.message)
          when "Error=MissingCollapseKey"
            ex = C2dm::Errors::MissingCollapseKey.new(response[:message])
            logger.warn(ex.message)
          else
            # notification.sent_at = Time.now
            # notification.save!
          end
        elsif response[:code] == 503
          raise C2dm::Errors:ServiceUnavailable.new(response[:message])
        elsif response[:code] == 401
          raise C2dm::Errors::InvalidAuthToken.new(response[:message])
        else
        end
      end
      
      # mark the notification as sent if no devices are associated
      unless devices_exist
        notification.sent_at = Time.now
        notification.save!
      end
      
    end
  end
end

