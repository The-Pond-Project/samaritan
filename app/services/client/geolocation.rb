# frozen_string_literal: true

module Client
  class Geolocation
    BASE_URI = "https://ipgeolocation.abstractapi.com/v1/?api_key=#{EnvSecret.get('GEOLOCATION_API_KEY')}"
    include HTTParty

    def self.get_location(ip_address)
      HTTParty.get("#{BASE_URI}&ip_address=#{ip_address}")
    end
  end
end
