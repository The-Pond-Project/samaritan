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
end
