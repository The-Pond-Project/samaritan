# frozen_string_literal: true

class Ripple < ApplicationRecord
  include PondRippleConcern

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

  # Validations
  validate :validate_uuid
  validates :uuid, presence: true, uniqueness: true
  validates :pond_id, :country, :city, presence: true

  # Associations
  belongs_to :user, optional: true
  belongs_to :pond, touch: true
  has_and_belongs_to_many :tags

  # Gem Configurations
  has_paper_trail
  acts_as_paranoid

  # Deligations
  delegate :key, to: :pond, prefix: true

  # Aliases
  alias_attribute :state, :region

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
end
