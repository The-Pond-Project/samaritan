# frozen_string_literal: true

FactoryBot.define do
  factory :ripple do
    uuid { SecureRandom.uuid }
    postal_code { '43235' }
    city { 'Columbus' }
    region { 'Ohio' }
    country { 'US' }
    association :user
    association :pond
  end
end
