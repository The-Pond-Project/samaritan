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

end
