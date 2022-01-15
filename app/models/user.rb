# frozen_string_literal: true

class User < ApplicationRecord
  # Schema Information
  # Table name: User
  #
  # id                            :integer      not null, primary key
  # email                         :string       not null, unique true
  # password                      :string       not null
  # role                          :integer      
  # invitation_token              :string       
  # invitation_limit              :integer      
  # invitations_count             :integer      
  # invited_by                    :integer
  # invitation_created_at         :datetime
  # invitation_sent_at            :datetime     
  # invitation_accepted_at        :datetime     
  # deleted_at                    :datetime
  # created_at                    :datetime     not null
  # updated_at                    :datetime     not null

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Roles
  enum role: { member: 0, admin: 1, super_admin: 2 }

  # Callbacks
  after_initialize :set_default_role, if: :new_record?

  # Validations
  validates :role, presence: true

  # Associations
  has_many :ripples

  # Gem Configurations
  has_paper_trail
  acts_as_paranoid

  #
  # Public Instance Method
  #
  # Returns a string of the users email name
  def username
    email.split('@').first
  end

  private

  def set_default_role
    self.role ||= :member
  end
end
