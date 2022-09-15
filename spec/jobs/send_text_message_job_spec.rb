# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SendTextMessageJob do
  subject { job.perform(to: to, message: message) }

  let(:job) { described_class.new }
  let(:message) { 'This is a message about Kindness' }
  let(:to) { '16147784523' }

  describe '#perform' do
    it 'sends sms message' do
      expect(TwilioTextMessenger).to receive(:message)
      subject
    end
  end
end
