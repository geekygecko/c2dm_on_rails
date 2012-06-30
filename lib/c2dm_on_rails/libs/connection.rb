require 'net/https'
require 'uri'

module C2dm
  module Connection
    
    class << self
      def send_notification(notification)
        registration_ids = [notification.device.registration_id]
        send_group_notification(notification, registration_ids)
      end
      # def send_notification(noty)
      #         headers = { "Content-Type" => "application/x-www-form-urlencoded", 
      #                     "Authorization" => "key=#{configatron.c2dm.api_key.strip}" }
      # 
      #         message_data = noty.data.map{|k, v| "&data.#{k}=#{URI.escape(v)}"}.reduce{|k, v| k + v}
      #         data = "registration_id=#{noty.device.registration_id.strip}&collapse_key=#{noty.collapse_key}#{message_data}"
      # 
      #         data = data + "&delay_while_idle" if noty.delay_while_idle
      # 
      #         url_string = configatron.c2dm.api_url
      #         url=URI.parse url_string
      #         http = Net::HTTP.new(url.host, url.port)
      #         http.use_ssl = true
      #         http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      #    
      #         resp, dat = http.post(url.path, data, headers)
      # 
      #         return {:code => resp.code.to_i, :message => dat} 
      #       end

      def send_group_notification(notification, registration_ids)
        headers = { "Content-Type" => "application/json", 
                    "Authorization" => "key=#{configatron.c2dm.api_key.strip}" }
        
        data_hash = {
          "collapse_key" => notification.collapse_key.strip,
          "data" => notification.data,
          "registration_ids" => registration_ids
        }
        data_hash["delay_while_idle"] = notification.delay_while_idle if notification.delay_while_idle
        data_hash["time_to_live"] = notification.time_to_live if notification.time_to_live
        
        data = data_hash.to_json

        logger.info "Sending data: #{data}"

        url_string = configatron.c2dm.api_url
        url=URI.parse url_string
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
   
        resp, dat = http.post(url.path, data, headers)

        return {:code => resp.code.to_i, :message => dat}
      end
    end
  end # Connection
end # C2dm
