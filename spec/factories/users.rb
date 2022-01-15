# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    role { [:member, :admin, :super_admin].sample }
  end
end
