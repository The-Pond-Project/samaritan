# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Story, type: :model do
  let(:story) { create(:story) }
  describe '#create' do
    it { is_expected.to validate_presence_of(:body) }

    describe 'with valid data' do
      it 'can create a story' do
        story
        expect(described_class.count).to eq 1
      end
    end
  end
end
