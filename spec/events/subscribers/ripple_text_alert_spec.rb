# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subscribers::RippleTextAlert do
  subject { described_class.alert_subscriber(subscription) }

  let(:subscription) { create(:message_subscription) }

  describe '#alert_subscriber' do
    context 'when ripple exist' do
      it 'sends sms message' do
        expect(TwilioTextMessenger).to receive(:message)
        subject
      end
    end

    context 'when ripple does NOT exist' do
      before { subscription.update(ripple_uuid: SecureRandom.uuid) }

      it 'does NOT send sms message' do
        expect(TwilioTextMessenger).not_to receive(:message)
        subject
      end
    end
  end
end
