# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'MessageSubscriptions', type: :request do
  let(:ripple) { create(:ripple) }
  let(:subscription_params) { { Body: "SUBSCRIBE #{ripple.uuid}", From: '+12345671890' } }
  let(:unusubscription_params) { { Body: 'UNSUBSCRIBE', From: message_sub.phone_number.to_s } }
  let(:junk_params) { { Body: 'junk', From: '+12345671890' } }
  let(:message_sub) { create(:message_subscription) }

  describe 'POST /sms' do
    it 'renders a successful response' do
      post messagesubscriptions_sms_url, params: subscription_params
      expect(response).to be_successful
    end

    it 'creates a subscription' do
      expect do
        post messagesubscriptions_sms_url, params: subscription_params
      end.to change { MessageSubscription.count }.by(1)
    end

    it 'does nothing a subscription' do
      expect do
        post messagesubscriptions_sms_url, params: junk_params
      end.not_to change { MessageSubscription.count }
    end

    it 'unsubscribes' do
      message_sub
      expect do
        post messagesubscriptions_sms_url, params: unusubscription_params
      end.to change { MessageSubscription.count }.by(-1)
    end
  end
end
