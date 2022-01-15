# frozen_string_literal: true

class Ripple < ApplicationRecord
  extend FriendlyId
  include PondRippleConcern
  include Rails.application.routes.url_helpers

  # Schema Information
  # Table name: Ripple
  #
  # id                  :integer      not null, primary key
  # uuid                :string       not null, unique true
  # user_id             :integer
  # pond_id             :integer      not null
  # postal_code         :string
  # city                :string
  # region              :string
  # country             :string
  # created_at          :datetime     not null
  # updated_at          :datetime     not null

  # Model Callbacks
  after_initialize :initialize_uuid
  before_create :convert_country_code
  before_validation :set_location_unknown
  after_validation :geocode

  # Validations
  validate :validate_uuid
  validate :tag_limit
  validates :uuid, presence: true, uniqueness: true
  validates :pond_id, :country, :city, presence: true

  # Associations
  belongs_to :user, optional: true
  belongs_to :pond, touch: true
  has_and_belongs_to_many :tags

  # Gem Configurations
  has_paper_trail
  acts_as_paranoid
  geocoded_by :address, if: :address_changed?
  friendly_id :uuid, use: :slugged

  # Deligations
  delegate :key, to: :pond, prefix: true

  # Aliases
  alias_attribute :state, :region

  # For rails routing
  # Override id as default route param
  def to_param
    uuid
  end

  #
  # Public Instance Method
  #
  # Returns an array of ripples that came after self
  def descendants
    Ripple.where(['created_at > ? and pond_id = ?', created_at, pond_id])
  end

  #
  # Public Instance Method
  #
  # Returns an array of ripples that came before self
  def ancestors
    Ripple.where(['created_at < ? and pond_id = ?', created_at, pond_id])
  end

  #
  # Public Instance Method
  #
  # Returns an integer count of descendant ripples
  def impact
    descendants.count
  end

  #
  # Public Instance Method
  #
  # Returns an integer count of international ripples
  def international_impact
    descendants.international.count
  end

  #
  # Public Instance Method
  #
  # Returns an integer count of domestic ripples
  def domestic_impact
    descendants.domestic.count
  end

  #
  # Public Instance Method
  #
  # Returns the ponds last ripple
  def last_descendant
    descendants.last
  end

  #
  # Public Instance Method
  #
  # Returns address in string form
  def address
    "#{city}, #{region} #{postal_code}, #{country}"
  end

  private

  #
  # Private Method#
  #
  # Used to check if an address_changed and geocoding is needed
  def address_changed?
    city_changed? || region_changed? || postal_code_changed? || \
      country_changed? || longitude_changed? || latitude_changed?
  end

  def tag_limit
    errors.add(:tags, 'exceed limit of 3') if tags.size > 3
  end
end
