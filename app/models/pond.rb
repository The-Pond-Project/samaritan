# frozen_string_literal: true

# rubocop:disable Lint/IneffectiveAccessModifier
class Pond < ApplicationRecord
  class GenerationError < StandardError; end
  include PondRippleConcern

  # Schema Information
  # Table name: Pond
  #
  # id                  :integer      not null, primary key
  # uuid                :string       not null, unique true
  # key                 :string       not null, unique true
  # postal_code         :string
  # region              :string
  # city                :string
  # country             :string
  # deleted_at          :datetime
  # created_at          :datetime     not null
  # updated_at          :datetime     not null

  # Model Callbacks
  after_initialize :initialize_uuid, :initialize_key
  before_create :convert_country_code

  # Validations
  validates :uuid, :key, presence: true, uniqueness: true
  validate :validate_key, :validate_uuid

  # Alias Attributes
  alias_attribute :state, :region
  alias_attribute :pond_key, :key

  # Associations
  has_many :ripples

  # Scopes
  scope :inactive, -> { where('updated_at < ?', Date.current.year - 45) }

  # Gem Configurations
  has_paper_trail
  acts_as_paranoid

  #
  # Public Class Method
  #
  # This method is a class method that will generate x amount of pond objects.
  # You can pass in a 2 Char unique pond code and a location hash
  # Amount: Interger, Location: Hash, unique_pond_code: Nil or String(2)
  def self.generate(amount:, location: {}, unique_pond_code: nil)
    validate_generate_args(amount: amount, location: location,
                           unique_pond_code: unique_pond_code)

    amount.times do
      create(
        key: unique_pond_code ? custom_hex_key(unique_pond_code) : standard_hex_key,
        postal_code: location[:postal_code],
        city: location[:city],
        region: location[:region],
        country: location[:country]
      )
    end
  end

  #
  # Public Instance Method
  #
  # Returns an integer count of ripples
  def impact
    ripples.count
  end

  #
  # Public Instance Method
  #
  # Returns an integer count of international ripples
  def international_impact
    ripples.international.count
  end

  #
  # Public Instance Method
  #
  # Returns an integer count of domestic ripples
  def domestic_impact
    ripples.domestic.count
  end

  #
  # Public Instance Method
  #
  # Returns the ponds last ripple
  def last_ripple
    ripples.last
  end

  private

  def initialize_key
    self.key = "P-#{SecureRandom.hex(3).upcase}" unless key
  end

  # Validation methods

  def validate_key
    return unless key

    errors.add(:key, 'must be a string') unless key.is_a?(String)
    errors.add(:key, 'must start with P-') unless key.first(2) == 'P-'
    errors.add(:key, 'must be 8 charcters long') unless key.size == 8
  end

  # standard pond key hex
  # Example: P-40326A
  def self.standard_hex_key
    "P-#{SecureRandom.hex(3).upcase}"
  end

  # custom pond key hex
  # Example if unique code was 'GN': P-GN326A
  def self.custom_hex_key(unique_code)
    "P-#{unique_code}".upcase + SecureRandom.hex(2).upcase
  end

  def self.validate_generate_args(amount:, location:, unique_pond_code: nil)
    if unique_pond_code && unique_pond_code.size > 2
      raise GenerationError, 'Pond Code must be 2 characters'
    end

    raise GenerationError, 'Pond location must be hash' unless location.is_a?(Hash)
    raise GenerationError, 'Amount must be Integer' unless amount.is_a?(Integer)
    raise GenerationError, 'Amount must be lower than 250' unless amount <= 250
  end
end
# rubocop:enable Lint/IneffectiveAccessModifier
