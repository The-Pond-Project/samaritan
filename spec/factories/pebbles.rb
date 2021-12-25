# frozen_string_literal: true

FactoryBot.define do
  factory :pebble do
    uuid { SecureRandom.uuid }
    postal_code { '43235' }
    city { 'Columbus' }
    region { 'Ohio' }
    country { 'US' }
    pebble_key { "P-#{SecureRandom.hex(3).upcase}" }
  end
end
