# frozen_string_literal: true

FactoryBot.define do
  factory :bill do
    name { Faker::Movie.title }
    recurrence { [*0..1].sample }
    expense_type { [*0..1].sample }
    amount { 300.00 }
    paid { Faker::Boolean.boolean }
    due_at { Time.current }
    description { Faker::Lorem.paragraph }
  end
end
