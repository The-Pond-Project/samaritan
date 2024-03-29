# frozen_string_literal: true

module Google
  class ReverseAddress
    attr_reader :latitude, :longitude, :response

    ADDRESS_ATTRIBURES = %w[
      locality
      country
      postal_code
      administrative_area_level_2
      administrative_area_level_1
    ]

    def initialize(latitude:, longitude:)
      @latitude = latitude
      @longitude = longitude
      @response = call.parsed_response&.dig('results').try(:first)
    end

    ADDRESS_ATTRIBURES.each do |attr|
      define_method(attr.to_sym) do
        return nil unless response

        value = response&.dig('address_components')&.select do |x|
          x&.dig('types')&.include?(attr)
        end.first
        value&.dig('long_name')
      end
    end

    # rubocop:disable Naming/VariableNumber
    alias county administrative_area_level_2
    alias region administrative_area_level_1
    alias city locality
    # rubocop:enable Naming/VariableNumber

    private

    def call
      Client::Google.reverse_address(latitude: latitude, longitude: longitude)
    end
  end
end
