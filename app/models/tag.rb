# frozen_string_literal: true

class Tag < ApplicationRecord
  extend FriendlyId
  # Schema Information
  # Table name: Tag
  #
  # id                  :integer      not null, primary key
  # name                :string       not null
  # approved            :boolean
  # description         :text         not null
  # organization        :string
  # deleted_at          :datetime
  # created_at          :datetime     not null
  # updated_at          :datetime     not null

  # Validations
  validate  :validate_tag_name
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :name, length: { in: 1..45 }
  validates :description, length: { in: 5..350 }

  # Associations
  belongs_to :organization
  has_and_belongs_to_many :ripples

  # Gem Configurations
  has_paper_trail
  acts_as_paranoid
  friendly_id :name, use: :slugged

  # Scopes
  scope :approved, -> { where({ approved: true }) }
  scope :pending_approval, -> { where({ approved: nil }) }
  scope :denied, -> { where({ approved: false }) }

  # Public Class Method
  # Return the most popular tag
  #
  def self.most_popular
    return unless RipplesTag.count.positive?

    tags_hash = joins(:ripples_tags).group(:tag_id).count
    tag_id = tags_hash.max_by { |_k, v| v }[0]
    find_by(id: tag_id)
  end

  def self.leaderboard
    includes(:organization)
      .joins(:ripples_tags)
      .group('tag_id', 'tags.id', 'tags.name')
      .order('COUNT(tags.id) DESC')
      .limit(5)
  end

  # For rails routing
  # Override id as default route param
  def to_param
    name
  end

  def approval
    return 'Pending' if approved.nil?
    return 'Denied' if approved.eql?(false)
    return 'Approved' if approved.eql?(true)
  end

  private

  def validate_tag_name
    return unless name

    errors.add(:name, 'must start with a #') unless name.first == '#'
    errors.add(:name, 'can not contain space') if name.include?(' ')
  end
end
