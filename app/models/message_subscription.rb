# frozen_string_literal: true

class MessageSubscription < ApplicationRecord
  # Schema Information
  # Table name: MessageSubscriptions
  #
  # id                  :integer      not null, primary key
  # ripple_uuid         :string       not null
  # phone_number        :string       not null
  # created_at          :datetime     not null
  # updated_at          :datetime     not null

  # Validations
  validates :ripple_uuid, :phone_number, presence: true
  validates :ripple_uuid, length: { is: 36 }
  validates :phone_number, length: { in: 8..15 }

  def self.for(ripples)
    @ripples = Array.wrap(ripples)
    return if @ripples.blank?
    MessageSubscription.where({ripple_uuid: @ripples})
  end
end
