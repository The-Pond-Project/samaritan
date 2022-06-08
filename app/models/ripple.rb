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
  after_create :notify_text_subscribers

  # Validations
  validate :validate_uuid
  validate :tag_limit
  validates :uuid, presence: true, uniqueness: true
  validates :uuid, length: { is: 36 }
  validates :pond_id, :country, :city, presence: true

  # Associations
  belongs_to :user, optional: true
  belongs_to :pond, touch: true
  has_one :organization, through: :pond
  has_one :release, through: :pond
  has_and_belongs_to_many :tags, touch: true

  # Gem Configurations
  has_paper_trail
  acts_as_paranoid
  geocoded_by :address, if: :address_changed?
  friendly_id :uuid, use: :slugged

  # Deligations
  delegate :key, to: :pond, prefix: true

  # Aliases
  alias_attribute :state, :region

  # Scopes
  scope :last_thirty_days, -> { where(['created_at >= ?', Time.zone.now - 30.days]) }

  #
  # Public Class Method
  #
  # Returns when the time since the last was ripple recorded and now
  # Example: '3 weeks ago'
  def self.ripple_since
    return if last.blank?

    created = last.created_at.to_time.to_i
    today = Time.now.to_time.to_i
    (today - created).ago.to_words
  end

  #
  # Public Class Method
  #
  # Returns the largest pond size
  #
  def self.largest_pond
    group(:pond_id).count.values.max || 0
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def self.average_time_between_ripples
    differences = []
    # 1. get created at for all ripples
    ripples_created_at = all.pluck(:created_at)

    return '0 hour average between Ripples of Kindness' if ripples_created_at.empty?

    # 2. get difference between each ripple
    prev_time = nil
    ripples_created_at.each do |time|
      if prev_time.nil?
        prev_time = time
        next
      end
      difference = time - prev_time
      differences.push(difference)
      prev_time = time
    end
    # 3. add differences
    average_seconds = differences.sum / ripples_created_at.count
    # 4. divide by the number of differences
    average_hours = (average_seconds / 3600).round(1) # 3600 seconds in a hour
    average_days = (average_seconds / 86_400).round(1) # 86400 seconds in a day

    if average_hours <= 23
      "#{average_hours} hour average between Ripples of Kindness"
    else
      "#{average_days} day average between Ripples of Kindness"
    end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def self.most_popular_city
    # Query for number of ripples in each zipcode
    postal_code_counts = group(:postal_code).count.reject { |k| k == 'Unknown' }
    return 'Unknown' if postal_code_counts.empty?

    # get zipcode with the most ripples
    result = postal_code_counts.max_by { |_k, v| v }
    # look up zipcode with geocode
    city = Geocoder.search(result[0]).first
    # return result
    city.display_name
  end

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

  def notify_text_subscribers
    Publishers::RippleCreated.call(self)
  end

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
