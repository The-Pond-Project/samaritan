# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MessageSubscription, type: :model do

  let(:subscription) { create(:message_subscription) }
  describe '#create' do
    describe 'with valid data' do
      it { is_expected.to validate_presence_of(:phone_number) }
      it { is_expected.to validate_presence_of(:ripple_uuid) }
      it { should validate_length_of(:ripple_uuid).is_equal_to(36) }
      it { should validate_length_of(:phone_number).is_at_least(8).is_at_most(15) }

      it 'can create a message subscription' do
        subscription
        expect(described_class.count).to eq 1
      end
    end
  end
end
