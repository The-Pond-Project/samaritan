# frozen_string_literal: true

FactoryBot.define do
  factory :story do
    title { Faker::Lorem.sentence(word_count: 3) }
    body { Faker::Lorem.paragraph }
    pond_key { 'P-ABC123' }
    ripple_uuid { SecureRandom.uuid }
  end
end
