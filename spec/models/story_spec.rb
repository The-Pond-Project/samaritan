# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Story, type: :model do
  let(:story) { create(:story) }
  describe '#create' do
    it { is_expected.to validate_presence_of(:body) }
    it { should validate_length_of(:title).is_at_most(45) }
    it { should validate_length_of(:body).is_at_least(5).is_at_most(2000) }

    describe 'with valid data' do
      it 'can create a story' do
        story
        expect(described_class.count).to eq 1
      end
    end
  end

  
  describe '#to_param' do 
    it 'returns uuid' do
      expect(story.to_param).to eq story.uuid
    end
  end
end
