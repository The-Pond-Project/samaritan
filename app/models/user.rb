# frozen_string_literal: true

class User < ApplicationRecord
  # Schema Information
  # Table name: User
  #
  # id                  :integer      not null, primary key
  # email               :string       not null, unique true
  # password            :string       not null, unique true
  # deleted_at          :datetime
  # created_at          :datetime     not null
  # updated_at          :datetime     not null

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :ripples

  # Gem Configurations
  has_paper_trail
  acts_as_paranoid

  def username
    email.split('@').first
  end
end
