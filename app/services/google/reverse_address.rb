# frozen_string_literal: true

module Google
  class ReverseAddress
    attr_reader :latitude, :longitude, :response

    def initialize(latitude:, longitude:)
      @latitude = latitude
      @longitude = longitude
      @response = call.parsed_response['results'].try(:first)
    end

    def region
      return nil unless response

      region = response['address_components'].select do |x|
        x['types'].include?('administrative_area_level_1')
      end.first
      region['long_name']
    end

    def city
      return nil unless response

      city = response['address_components'].select { |x| x['types'].include?('locality') }.first
      city['long_name']
    end

    def postal_code
      return nil unless response

      postal_code = response['address_components'].select do |x|
        x['types'].include?('postal_code')
      end.first
      postal_code['long_name']
    end

    def country
      return nil unless response

      country = response['address_components'].select { |x| x['types'].include?('country') }.first
      country['long_name']
    end

    def county
      return nil unless response

      county = response['address_components'].select do |x|
        x['types'].include?('administrative_area_level_2')
      end.first
      county['long_name']
    end

    private

    def call
      Client::Google.reverse_address(latitude: latitude, longitude: longitude)
    end
  end
end
