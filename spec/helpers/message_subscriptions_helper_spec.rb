# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MessageSubscriptionsHelper, type: :helper do
  # rubocop:disable RSpec/MultipleMemoizedHelpers
  let(:ripple) { create(:ripple) }
  let(:subscription_params) { { Body: "SUBSCRIBE #{ripple.uuid}", From: '+12345671890' } }
  let(:unusubscription_params) { { Body: 'UNSUBSCRIBE', From: message_sub.phone_number.to_s } }
  let(:junk_params) { { Body: 'junk', From: '+12345671890' } }
  let(:message_sub) { create(:message_subscription) }

  describe '#create_response_body' do
    it 'creates a subscription' do
      expect do
        helper.create_response_body(subscription_params)
      end.to change { MessageSubscription.count }.by(1)
    end

    it 'does nothing a subscription' do
      expect do
        helper.create_response_body(junk_params)
      end.not_to change { MessageSubscription.count }
    end

    it 'unsubscribes' do
      message_sub
      expect do
        helper.create_response_body(unusubscription_params)
      end.to change { MessageSubscription.count }.by(-1)
    end

    describe 'message response' do
      let(:invalid_subscription) do
        { Body: "SUBSCRIBE #{SecureRandom.uuid}", From: '+12345671890' }
      end
      let(:invalid_unsubscription) do
        { Body: 'UNSUBSCRIBE', From: '+12345671890' }
      end

      it 'for SUBSCRIBE' do
        message = 'has been subscribed to receive updates'
        expect(helper.create_response_body(subscription_params)).to include(message)
      end

      it 'for invalid SUBSCRIBE' do
        message = 'Please check your ripple id and try again'
        expect(helper.create_response_body(invalid_subscription)).to include(message)
      end

      it 'for UNSUBSCRIBE' do
        message = 'has been unsubscribed'
        expect(helper.create_response_body(unusubscription_params)).to include(message)
      end

      it 'for invalid UNSUBSCRIBE' do
        message = 'I did not find a subscription with the number'
        expect(helper.create_response_body(invalid_unsubscription)).to include(message)
      end

      it 'for junk texts' do
        message = 'Sorry I didn\'t get that'
        expect(helper.create_response_body(junk_params)).to include(message)
      end
    end
  end
  # rubocop:enable RSpec/MultipleMemoizedHelpers
end
