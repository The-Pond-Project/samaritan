# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Publishers::RippleCreated do
  let(:pond) { create(:pond) }
  let(:first_ripple) { create(:ripple, pond: pond) }
  let(:subscription) { create(:message_subscription, ripple_uuid: first_ripple.uuid) }
  let(:ripple) { create(:ripple, pond: pond) }

  before { subscription }

  describe '#call' do
    context 'when the ripple has ancestors' do
      it 'broadcast the alert_subscriber' do
        allow(MessageSubscription).to receive(:for) { [subscription] }
        expect { ripple }.to broadcast(:alert_subscriber, subscription)
      end
    end

    context 'when the ripple does NOT have ancestors' do
      it 'does NOT broadcast' do
        expect { first_ripple }.to not_broadcast(:alert_subscriber)
      end
    end
  end
end
