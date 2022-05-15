# frozen_string_literal: true

require 'uri'

# rubocop:disable Rails/UniqueValidationWithoutIndex
class Organization < ApplicationRecord
  extend FriendlyId

  # Schema Information
  # Table name: Organization
  #
  # id                  :integer      not null, primary key
  # name                :string       not null, unique true
  # description         :string       not null
  # website             :string
  # address             :string
  # deleted_at          :datetime
  # created_at          :datetime     not null
  # updated_at          :datetime     not null

  # Validations
  validates :name, uniqueness: true
  validates :name, :description, presence: true
  validates :name, length: { in: 5..45 }
  validates :description, length: { in: 5..350 }
  validate :correct_image_type
  validate :url_format

  # Associations
  has_many :tags, dependent: :destroy
  has_many :releases, dependent: :destroy
  has_many :ponds, through: :releases
  has_many :ripples, through: :ponds
  has_one_attached :image

  # Gem Configurations
  has_paper_trail
  acts_as_paranoid
  friendly_id :name, use: :slugged

  # Scope
  scope :with_attached_image, -> { includes(image_attachment: :blob) }

  # For rails routing
  # Override id as default route param
  def to_param
    name
  end

  #
  # Public Instance Method
  #
  # Returns when the time since the last was ripple recorded and now
  # Example: '3 weeks ago'
  def last_ripple_was
    return 'No Ripples have been recorded yet' if ripples.last.blank?

    created = ripples.last.created_at.to_time.to_i
    today = Time.now.to_time.to_i
    "Last Ripple was #{(today - created).ago.to_words}"
  end

  private

  def correct_image_type
    return unless image.attached?

    unless image.content_type.in?(%w[image/jpeg image/png])
      errors.add(:image, 'must be a jpeg or png')
    end
  end

  def url_format
    return unless website

    uri = URI.parse(website)
    errors.add(:website, 'invalid format. Example: https://kindnesspassedon.org ') unless uri&.host
  end
end
# rubocop:enable Rails/UniqueValidationWithoutIndex
