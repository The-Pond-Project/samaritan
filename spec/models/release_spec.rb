# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Release, type: :model do
  let(:release) { create(:release) }
  let(:ponds) { create_list(:pond, 5, release: release) }
  describe '#create' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(5).is_at_most(45) }
    it { is_expected.to validate_length_of(:description).is_at_least(5).is_at_most(350) }

    context 'with valid data' do
      it 'can create a release' do
        release
        expect(described_class.count).to eq 1
      end
    end
  end

  describe '#average_release_size' do
    context 'when there is a release amount and pond count' do
      before { ponds }

      it 'returns the proper average' do
        expect(described_class.average_release_size).to eq(5)
      end
    end

    context 'when the pond count is zero' do
      it 'returns 0' do
        expect(described_class.average_release_size).to eq(0)
      end
    end
  end
end
