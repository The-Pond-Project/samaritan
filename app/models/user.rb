# frozen_string_literal: true

class User < ApplicationRecord
  # Schema Information
  # Table name: User
  #
  # id                  :integer      not null, primary key
  # email               :string       not null, unique true
  # password            :string       not null, unique true
  # created_at          :datetime     not null
  # updated_at          :datetime     not null

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :ripples

  def username
    email.split('@').first
  end
end
