# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    role { [:member, :admin, :super_admin].sample }

    trait :super_admin do
      role { :super_admin }
    end

    trait :admin do
      role { :admin }
    end

    trait :member do
      role { :member }
    end
  end
end
