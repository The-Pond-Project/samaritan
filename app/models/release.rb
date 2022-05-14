# frozen_string_literal: true

class Release < ApplicationRecord
  extend FriendlyId

  # Schema Information
  # Table name: Release
  #
  # id                  :integer      not null, primary key
  # name                :string       not null, unique true
  # description         :string       not null
  # organization_id     :integer      not null
  # deleted_at          :datetime
  # created_at          :datetime     not null
  # updated_at          :datetime     not null

  # Validations
  validates :name, :description, presence: true
  validates :description, length: { in: 5..350 }
  validates :name, length: { in: 5..45 }

  # Gem Configurations
  has_paper_trail
  acts_as_paranoid
  friendly_id :name, use: :slugged

  # Associations
  has_many :ponds, dependent: :destroy
  has_many :pond_batch_records, dependent: :destroy
  belongs_to :organization

  # Public Class Mehtod
  #
  #
  # Returns the dividen of the total releases
  #
  def self.average_release_size
    releases = Release.count
    # since every pond has to belong to a release
    # we can just use the count of all ponds
    ponds = Pond.count
    return 0 if releases.zero? || ponds.zero?

    ponds / releases
  end
end
