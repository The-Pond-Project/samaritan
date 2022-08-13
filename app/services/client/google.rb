# frozen_string_literal: true

module Client
  class Google
    REVERSE_ADDRESS_BASE_URI = 'https://maps.googleapis.com/maps/api/geocode/json?'
    include HTTParty

    # rubocop:disable Layout/LineLength
    def self.reverse_address(latitude:, longitude:)
      HTTParty.get(
        "#{REVERSE_ADDRESS_BASE_URI}latlng=#{latitude}, #{longitude}&result_type=postal_code|country|administrative_area_level_1|administrative_area_level_2|sublocality&key=#{EnvSecret.get('GOOGLE_MAPS_API_SERVER_KEY')}", timeout: 15
      )
    end
    # rubocop:enable Layout/LineLength
  end
end
