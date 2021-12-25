# frozen_string_literal: true

FactoryBot.define do
  factory :pond do
    uuid { SecureRandom.uuid }
    postal_code { '43235' }
    city { 'Columbus' }
    region { 'Ohio' }
    country { 'US' }
    key { "P-#{SecureRandom.hex(3).upcase}" }
  end
end
