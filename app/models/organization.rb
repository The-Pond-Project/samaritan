# frozen_string_literal: true

require 'uri'

class Organization < ApplicationRecord
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
  validates :name, :description, presence: true, uniqueness: true
  validate :correct_image_type
  validate :url_format

  # Associations
  has_many :ripples
  has_one_attached :image

  # Gem Configurations
  has_paper_trail
  acts_as_paranoid

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
