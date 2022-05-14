# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.describe Tag, type: :model do
  subject { described_class.new }

  let(:organization) { create(:organization) }
  let(:approved_tags) { create_list(:tag, 3, approved: true, organization: organization) }
  let(:pending_approval) { create_list(:tag, 3, approved: nil, organization: organization) }
  let(:denied) { create_list(:tag, 3, approved: false, organization: organization) }
  let(:ripple) { create(:ripple) }
  let(:ripples) { create_list(:ripple, 3) }
  let(:tag) { create(:tag, organization: organization) }

  describe '#create' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_length_of(:name).is_at_least(1).is_at_most(45) }
    it { is_expected.to validate_length_of(:description).is_at_least(5).is_at_most(350) }

    describe 'with valid data' do
      it 'can create a tag' do
        tag
        expect(described_class.count).to eq 1
      end
    end

    describe 'with invalid' do
      describe '#name' do
        context 'without a # start' do
          let(:tag) { create(:tag, name: 'Columbus', organization: organization) }

          it 'NOT create a tag' do
            expect { tag }.to raise_error(ActiveRecord::RecordInvalid)
          end
        end

        context 'when spacing is invalid' do
          let(:tag) { create(:tag, name: '#Columbus is cool', organization: organization) }

          it 'can NOT create a tag' do
            expect { tag }.to raise_error(ActiveRecord::RecordInvalid)
          end
        end
      end
    end
  end

  describe '#ripples' do
    it 'returns all of its ripples' do
      tag.ripples << ripples
      expect(tag.ripples).to eq ripples
    end
  end

  describe '#approved' do
    it 'returns all approved tags' do
      expect(described_class.approved).to eq approved_tags
    end
  end

  describe '#pending_approval' do
    it 'returns all tags pending approval' do
      expect(described_class.pending_approval).to eq pending_approval
    end
  end

  describe '#denied' do
    it 'returns all denied tags' do
      expect(described_class.denied).to eq denied
    end
  end

  describe '#to_param' do
    it 'returns name' do
      expect(tag.to_param).to eq tag.name
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
