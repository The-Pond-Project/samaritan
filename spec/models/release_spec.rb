# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Release, type: :model do
  let(:release) { create(:release) }
  describe '#create' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(5).is_at_most(45) }
    it { should validate_length_of(:description).is_at_least(5).is_at_most(350) }

    context 'with valid data' do
      it 'can create a release' do
        release
        expect(described_class.count).to eq 1
      end
    end
  end
end