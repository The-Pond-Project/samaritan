# frozen_string_literal: true

FactoryBot.define do
  factory :message_subscription do
    phone_number { "+1#{rand.to_s[2..11]}" }
    ripple_uuid { SecureRandom.uuid }

    before(:create) do |message_sub|
      ripple = create(:ripple)
      message_sub.ripple_uuid = ripple.uuid
    end
  end
end
