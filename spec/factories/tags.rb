# frozen_string_literal: true

FactoryBot.define do
  factory :tag do
    name { "##{Faker::Verb.base}" }
    description { 'Pass it on!' }
    approved { Faker::Boolean.boolean }
    association :organization
  end

  def tag_with_ripples(ripples_count: 2)
    FactoryBot.create(:tag) do |tag|
      FactoryBot.create_list(:ripples, ripples_count, tags: [tag])
    end
  end
end
