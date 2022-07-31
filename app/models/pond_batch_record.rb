# frozen_string_literal: true

# Schema Information
# Table name: PondBatchRecord
#
# id                  :integer      not null, primary key
# release_id          :integer      not null
# amount              :integer      not null
# deleted_at          :datetime
# created_at          :datetime     not null
# updated_at          :datetime     not null

class PondBatchRecord < ApplicationRecord
  # Validations
  validates :amount, presence: true
  validate :csv_file_type
  validate :zip_file_type

  # Associations
  belongs_to :release
  has_one :organization, through: :release
  has_one_attached :csv_file, dependent: :destroy
  has_one_attached :zip_file, dependent: :destroy

  # Gem Configurations
  has_paper_trail
  acts_as_paranoid

  private

  def csv_file_type
    return unless csv_file.attached?

    errors.add(:csv_file, 'must be a csv') unless csv_file.content_type.in?(%w[text/csv])
  end

  def zip_file_type
    return unless zip_file.attached?

    errors.add(:zip_file, 'must be a zip') unless zip_file.content_type.in?(%w[application/zip])
  end
end
