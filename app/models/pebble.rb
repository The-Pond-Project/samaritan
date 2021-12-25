# frozen_string_literal: true

# rubocop:disable Lint/IneffectiveAccessModifier
class Pebble < ApplicationRecord
  class GenerationError < StandardError; end

  DOMESTIC = ['United States of America', 'US']
  # Schema Information
  # Table name: Pebble
  #
  # id                  :integer      not null, primary key
  # uuid                :string       not null, unique true
  # pebble_key          :string       not null, unique true
  # postal_code         :string
  # region              :string
  # country             :string
  # created_at          :datetime     not null
  # updated_at          :datetime     not null

  # Model Callbacks
  after_initialize :initialize_uuid, :initialize_pebble_key
  before_create :convert_country_code

  # Validations
  validates :uuid, :pebble_key, presence: true, uniqueness: true
  validate :validate_pebble_key, :validate_uuid

  # Alias Attributes
  alias_attribute :state, :region
  alias_attribute :key, :pebble_key

  # Scopes
  scope :domestic, -> { where({ country: DOMESTIC }) }
  scope :international, -> { where.not({ country: DOMESTIC }) }

  #
  # Public Class Method
  #
  # This method is a class method that will generate x amount of pebble objects.
  # You can pass in a 2 Char unique pebble code and a location hash
  # Amount: Interger, Location: Hash, Unique_pebble_code: Nil or String(2)
  def self.generate(amount:, location: {}, unique_pebble_code: nil)
    validate_generate_args(amount: amount, location: location,
                           unique_pebble_code: unique_pebble_code)

    amount.times do
      create(
        pebble_key: unique_pebble_code ? custom_hex_key(unique_pebble_code) : standard_hex_key,
        postal_code: location[:postal_code],
        city: location[:city],
        region: location[:region],
        country: location[:country]
      )
    end
  end

  #
  # Public Instance Method
  # Used to see if a particular pebble is based in the States
  def domestic?
    DOMESTIC.include?(country)
  end

  private

  def initialize_uuid
    self.uuid = SecureRandom.uuid unless uuid
  end

  def initialize_pebble_key
    self.pebble_key = "P-#{SecureRandom.hex(3).upcase}" unless pebble_key
  end

  def convert_country_code
    return if country && country.size > 3

    self.country = ISO3166::Country.new(country).name unless country.nil?
  end

  # Validation methods

  def validate_pebble_key
    return unless pebble_key

    errors.add(:pebble_key, 'must be a string') unless pebble_key.is_a?(String)
    errors.add(:pebble_key, 'must start with P-') unless pebble_key.first(2) == 'P-'
    errors.add(:pebble_key, 'must be 8 charcters long') unless pebble_key.size == 8
  end

  def validate_uuid
    return unless uuid

    errors.add(:uuid, 'must be a string') unless uuid.is_a?(String)
    errors.add(:uuid, 'must be 36 charcters long') unless uuid.size == 36
    errors.add(:uuid, 'must be include -') unless uuid.include? '-'
  end

  # standard pebble key hex
  # Example: P-40326A
  def self.standard_hex_key
    "P-#{SecureRandom.hex(3).upcase}"
  end

  # custom pebble key hex
  # Example if unique code was 'GN': P-GN326A
  def self.custom_hex_key(unique_code)
    "P-#{unique_code}".upcase + SecureRandom.hex(2).upcase
  end

  def self.validate_generate_args(amount:, location:, unique_pebble_code: nil)
    if unique_pebble_code && unique_pebble_code.size > 2
      raise GenerationError, 'Pebble Code must be 2 characters'
    end

    raise GenerationError, 'Pebble location must be hash' unless location.is_a?(Hash)
    raise GenerationError, 'Amount must be Integer' unless amount.is_a?(Integer)
    raise GenerationError, 'Amount must be lower than 250' unless amount <= 250
  end
end
# rubocop:enable Lint/IneffectiveAccessModifier
