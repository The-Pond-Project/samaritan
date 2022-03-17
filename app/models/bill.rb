# frozen_string_literal: true

class Bill < ApplicationRecord
  extend FriendlyId

  # Schema Information
  # Table name: Bill
  #
  # id                  :integer      not null, primary key
  # name                :string       not null
  # description         :string       not null
  # recurrence          :integer
  # expense_type        :integer
  # paid                :boolean      not null
  # amount              :float        not null
  # due_at              :datetime     not null
  # deleted_at          :datetime
  # created_at          :datetime     not null
  # updated_at          :datetime     not null

  enum recurrence: { annual: 0, monthly: 1 }
  enum expense_type: { fixed: 0, variable: 1 }

  # Validations
  validates :name, :description, :amount, :due_at, presence: true
  validates :recurrence, :expense_type, presence: true
  validates :name, length: { in: 5..45 }
  validates :paid, inclusion: { in: [true, false] }
  validates :description, length: { in: 5..350 }
  validate :correct_document_type

  # Associations
  has_one_attached :document

  # Gem Configurations
  has_paper_trail
  acts_as_paranoid
  friendly_id :name, use: :slugged

  # For rails routing
  # Override id as default route param
  # def to_param
  #   name
  # end

  private

  def correct_document_type
    return unless document.attached?

    errors.add(:document, 'must be a pdf') unless document.content_type.in?(%w[application/pdf])
  end
end
