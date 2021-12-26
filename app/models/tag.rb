# frozen_string_literal: true

class Tag < ApplicationRecord
  # Schema Information
  # Table name: Tag
  #
  # id                  :integer      not null, primary key
  # name                :string       not null
  # approved            :boolean
  # description         :text         not null
  # organization        :string
  # created_at          :datetime     not null
  # updated_at          :datetime     not null

  # Validations
  validate  :validate_tag_name
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :description, length: { maximum: 200 }
  validates :name, length: { maximum: 25 }

  # Associations
  has_and_belongs_to_many :ripples

  # Gem Configurations
  has_paper_trail
  acts_as_paranoid
  

  # Scopes
  scope :approved, -> { where({ approved: true }) }
  scope :pending_approval, -> { where({ approved: nil }) }
  scope :denied, -> { where({ approved: false }) }

  private

  def validate_tag_name
    return unless name

    errors.add(:name, 'must start with a #') unless name.first == '#'
    errors.add(:name, 'can not contain space') if name.include?(' ')
  end
end
