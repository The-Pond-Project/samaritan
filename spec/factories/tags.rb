# frozen_string_literal: true

FactoryBot.define do
  factory :tag do
    name { Faker::Verb.base.to_s }
    description { 'Pass it on!' }
    organization { 'Kindnesspassedon' }
    approved { Faker::Boolean.boolean }
  end

  def tag_with_ripples(ripples_count: 2)
    FactoryBot.create(:tag) do |tag|
      FactoryBot.create_list(:ripples, ripples_count, tags: [tag])
    end
  end
end
