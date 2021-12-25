# frozen_string_literal: true

class Ripple < ApplicationRecord
  include PebbleRippleConcern

  # Schema Information
  # Table name: Ripple
  #
  # id                  :integer      not null, primary key
  # uuid                :string       not null, unique true
  # user_id             :integer
  # pebble_id           :integer      not null
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
  validates :pebble_id, :country, :city, presence: true

  # Associations
  belongs_to :user, optional: true
  belongs_to :pebble
  has_and_belongs_to_many :tags

  def ripples_since
    Ripple.where(['created_at > ? and pebble_id = ?', created_at, pebble_id])
  end
end
