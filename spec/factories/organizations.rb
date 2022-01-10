# frozen_string_literal: true

FactoryBot.define do
  factory :organization do
    name { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph }
    address { Faker::Address.full_address }
    website { "https://www.#{Faker::Internet.domain_name(domain: 'kindnesspassedon')}" }
    image { Rack::Test::UploadedFile.new('spec/fixtures/logo_default.png', 'image/png') }
  end
end
