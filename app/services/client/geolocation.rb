# frozen_string_literal: true

module Client
  class Geolocation
    IP_GEOLOCATION_BASE_URI = 'https://ipgeolocation.abstractapi.com/v1/?api_key=f623e96699164355b3840dc5fc47ff32'

    def self.get_location_from_ip_address(ip_address)
      HTTParty.get("#{IP_GEOLOCATION_BASE_URI}&ip_address=#{ip_address}", timeout: 15)
    end
  end
end
