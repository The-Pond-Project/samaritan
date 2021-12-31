# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MessageSubscription, type: :model do
  describe '#create' do
    describe 'with valid data' do
      it { is_expected.to validate_presence_of(:phone_number) }
      it { is_expected.to validate_presence_of(:ripple_uuid) }

      it 'can create a message subscription' do
        described_class.create(phone_number: Faker::PhoneNumber.cell_phone_in_e164,
                               ripple_uuid: SecureRandom.uuid)
        expect(described_class.count).to eq 1
      end
    end
  end
end
