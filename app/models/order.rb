# frozen_string_literal: true

class Order < ApplicationRecord
  # Schema Information
  # Table name: Order
  #
  # id                  :integer      not null, primary key
  # uuid                :string       not null, unique true
  # amount              :integer
  # email               :string
  # phone               :string
  # address1            :integer      not null
  # address2            :string
  # postal_code         :string       not null
  # region              :string       not null
  # city                :string       not null
  # country             :string       not null
  # shipped             :boolean       not null
  # deleted_at          :datetime
  # created_at          :datetime     not null
  # updated_at          :datetime     not null

  # Model Callbacks
  after_initialize :initialize_uuid

  # Validations
  validates :amount, :address1, :postal_code, :region, :city, :country, presence: true
  validates :shipped, inclusion: { in: [true, false] }
  validates :uuid, presence: true, uniqueness: true
  validates :uuid, length: { is: 36 }
  validate  :validate_uuid

  # Alias Attributes
  alias_attribute :state, :region
  # alias_attribute :shipped, :shipped?

  # Scopes
  scope :recent, -> { where(['created_at <= ?', Time.current - 7.days]) }
  scope :needs_shipped, -> { where(['shipped < ?', false]) }
  scope :shipped, -> { where(['shipped < ?', true]) }

  # Gem Configurations
  has_paper_trail

  #
  # Public Instance Method
  #
  # Returns full address in string form
  def full_address
    if address2.present?
      "#{address1} #{address2}, #{city}, #{region} #{postal_code}"
    else
      "#{address1}, #{city}, #{region} #{postal_code}"
    end
  end

  #
  # Public Instance Method
  #
  # Returns fullname in string form
  def fullname
    "#{first_name} #{last_name}"
  end

  # For rails routing
  # Override id as default route param
  def to_param
    uuid
  end

  private

  def initialize_uuid
    self.uuid ||= SecureRandom.uuid
  end

  # Validation methods

  def validate_uuid
    return unless uuid

    errors.add(:uuid, 'must be a string') unless uuid.is_a?(String)
    errors.add(:uuid, 'must be 36 charcters long') unless uuid.size == 36
    errors.add(:uuid, 'must be include -') unless uuid.include? '-'
  end
end
