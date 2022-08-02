# frozen_string_literal: true

class Pond < ApplicationRecord
  extend FriendlyId
  include PondRippleConcern

  # Schema Information
  # Table name: Pond
  #
  # id                  :integer      not null, primary key
  # uuid                :string       not null, unique true
  # key                 :string       not null, unique true
  # release_id          :integer      not null,
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
  validates :uuid, length: { is: 36 }
  validates :key, length: { is: 8 }
  validate :validate_key, :validate_uuid

  # Alias Attributes
  alias_attribute :state, :region
  alias_attribute :pond_key, :key

  # Associations
  has_many :ripples, dependent: :destroy
  belongs_to :release
  has_one :organization, through: :release

  # Scopes
  scope :inactive, -> { where(['updated_at < ?', Time.zone.now - 45.days]) }
  scope :active, -> { where.not(['updated_at < ?', Time.zone.now - 45.days]) }

  # Gem Configurations
  has_paper_trail
  acts_as_paranoid
  friendly_id :key, use: :slugged

  #
  # Public Instance Method
  #
  # Returns a url for it self
  def url
    ::Routes.pond_url(self)
  end

  #
  # Public Instance Method
  #
  # Returns a new ripple url for it self
  def new_ripple_url
    ::Routes.new_pond_ripple_url(self)
  end

  #
  # Public Instance Method
  #
  # Returns if a ripple is active or not
  def create_qr_code
    qrcode = RQRCode::QRCode.new(new_ripple_url)

    qrcode.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: '#1484ac',
      file: nil,
      fill: 'white',
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 300
    )
  end

  #
  # Public Instance Method
  #
  # Returns if a ripple is active or not
  def active?
    updated_at < Time.current - 45.days
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

  #
  # Public Instance Method
  #
  # Returns when the time since ponds last ripple was recorded and now
  # Example: '3 weeks ago'
  def ripple_since
    created = ripples.last&.created_at&.to_time&.to_i
    today =  Time.now.to_time.to_i
    (today - created).ago.to_words if created && today
  end

  # For rails routing
  # Override id as default route param
  def to_param
    key
  end

  private

  def initialize_key
    self.key ||= "P-#{SecureRandom.hex(3).upcase}"
  end

  # Validation methods

  def validate_key
    return unless key

    errors.add(:key, 'must be a string') unless key.is_a?(String)
    errors.add(:key, 'must start with P-') unless key.first(2) == 'P-'
    errors.add(:key, 'must be 8 charcters long') unless key.size == 8
  end
end
