# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable RSpec/DescribeClass
RSpec.describe 'Text Subscription Integration Tests' do
  let(:subscription) { create(:message_subscription) }
  let(:ripple) { build(:ripple, pond: Pond.last) }

  describe 'ripple text subscription' do
    context 'with valid data' do
      before do
        subscription
        Flipper.enable(:text_subscriptions)
      end

      it 'calls publisher' do
        expect(Publishers::RippleCreated).to receive(:call).with(ripple)
        ripple.save
      end

      it 'broadcast event to subscriber' do
        expect { ripple.save }.to broadcast(:alert_subscriber, subscription)
      end

      it 'runs text alert in background' do
        expect(Wisper::SidekiqBroadcaster::Worker.new).to respond_to(:perform)
        ripple.save
      end

      it 'sends sms message' do
        expect(TwilioTextMessenger).to receive(:message)
        Subscribers::RippleTextAlert.alert_subscriber(subscription)
      end
    end
  end
end
# rubocop:enable RSpec/DescribeClass
