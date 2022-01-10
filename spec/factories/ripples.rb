# frozen_string_literal: true

FactoryBot.define do
  factory :ripple do
    uuid { SecureRandom.uuid }
    postal_code { '43235' }
    city { 'Columbus' }
    region { 'Ohio' }
    country { 'US' }
    longitude { Faker::Address.longitude }
    latitude { Faker::Address.latitude }
    association :user
    association :pond
    association :tag
  end
end
