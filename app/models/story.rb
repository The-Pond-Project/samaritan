# frozen_string_literal: true

class Story < ApplicationRecord
  # Schema Information
  # Table name: Stories
  #
  # id                  :integer      not null, primary key
  # title               :string
  # body                :text         not null
  # pond_key            :string
  # ripple_uuid         :string
  # created_at          :datetime     not null
  # updated_at          :datetime     not null

  # Validations
  validates :body, presence: true
  validates :body, length: { in: 5..2000 }
  validates :title, length: { maximum: 45 }

  # Callbacks
  after_initialize :initialize_uuid,
                   def initialize_uuid
                     self.uuid ||= SecureRandom.uuid
                   end

  # For rails routing
  # Override id as default route param
  def to_param
    uuid
  end
end
