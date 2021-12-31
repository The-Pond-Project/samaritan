# frozen_string_literal: true

FactoryBot.define do
  factory :message_subscription do
    phone_number { Faker::PhoneNumber.cell_phone_in_e164 }
    ripple_uuid { SecureRandom.uuid }

    before(:create) do |message_sub|
      ripple = create(:ripple)
      message_sub.ripple_uuid = ripple.uuid
    end
  end
end
