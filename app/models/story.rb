# frozen_string_literal: true

class Story < ApplicationRecord
  # Schema Information
  # Table name: Stories
  #
  # id                  :integer      not null, primary key
  # title               :string
  # body                :text         not null
  # pond_key            :string
  # uuid                :string       not null
  # ripple_uuid         :string
  # created_at          :datetime     not null
  # updated_at          :datetime     not null

  # Validations
  validates :body, presence: true

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
