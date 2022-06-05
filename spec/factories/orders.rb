# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    uuid { SecureRandom.uuid }
    phone { '+16145328901' }
    postal_code { '43235' }
    city { 'Columbus' }
    region { 'Ohio' }
    country { 'US' }
    amount { rand(0..10) }
    email { 'kindnesspassedon@gmail.com' }
    address1 { '123 main st' }
    address2 { 'Apt 103' }
    first_name { 'Bill' }
    last_name { 'Will' }
    shipped { false }
  end
end
