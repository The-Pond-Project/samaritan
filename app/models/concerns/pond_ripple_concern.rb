# frozen_string_literal: true

module PondRippleConcern
  extend ActiveSupport::Concern

  DOMESTIC = ['United States of America', 'US']

  included do
    scope :domestic, -> { where({ country: DOMESTIC }) }
    scope :international, -> { where.not({ country: DOMESTIC }) }
  end

  #
  # Public Instance Method
  # Used to see if a particular object is based in the States
  #
  def domestic?
    DOMESTIC.include?(country)
  end

  #
  # Public Instance Method
  #
  # Returns full location in string form
  def full_location
    "#{city}, #{region}, #{country}"
  end

  private

  def initialize_uuid
    self.uuid ||= SecureRandom.uuid
  end

  def convert_country_code
    return if country&.size > 3

    self.country = ISO3166::Country.new(country).name if country.present?
  end

  def set_location_unknown
    self.country ||= 'Unknown'
    self.region ||= 'Unknown'
    self.city ||= 'Unknown'
    self.postal_code ||= 'Unknown'
  end

  def validate_uuid
    return unless uuid

    errors.add(:uuid, 'must be a string') unless uuid.is_a?(String)
    errors.add(:uuid, 'must be 36 charcters long') unless uuid.size == 36
    errors.add(:uuid, 'must be include -') unless uuid.include? '-'
  end
end
