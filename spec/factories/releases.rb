# frozen_string_literal: true

FactoryBot.define do
  factory :release do
    name { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph }
    association :organization
  end
end
