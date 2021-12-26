# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tag, type: :model do
  subject { described_class.new }

  let(:approved_tags) { create_list(:tag, 3, approved: true) }
  let(:pending_approval) { create_list(:tag, 3, approved: nil) }
  let(:denied) { create_list(:tag, 3, approved: false) }
  let(:ripple) { create(:ripple) }
  let(:ripples) { create_list(:ripple, 3) }

  describe '#create' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }

    describe 'with valid data' do
      it 'can create a tag' do
        described_class.create(name: '#Columbus', description: 'Represent Columbus',
                               organization: 'Kindnesspassedon')
        expect(described_class.count).to eq 1
      end

      it 'can create a ripple without a organization' do
        described_class.create(name: '#Columbus', description: 'Represent Columbus')
        expect(described_class.count).to eq 1
      end
    end

    describe 'with invalid' do
      describe '#name' do
        it 'start can NOT create a tag' do
          described_class.create(name: 'Columbus', description: 'Represent Columbus',
                                 organization: 'Kindnesspassedon')
          expect(described_class.count).to eq 0
        end

        it 'spacing can NOT create a tag' do
          described_class.create(name: 'Columbus is cool', description: 'Represent Columbus',
                                 organization: 'Kindnesspassedon')
          expect(described_class.count).to eq 0
        end

        it 'size can NOT create a tag' do
          described_class.create(name: "##{Faker::Lorem.characters(number: 25)}",
                                 description: 'Represent Columbus',
                                 organization: 'Kindnesspassedon')
          expect(described_class.count).to eq 0
        end
      end

      describe '#description' do
        it 'can NOT create a tag' do
          described_class.create(name: 'Columbus',
                                 description: Faker::Lorem.characters(number: 250),
                                 organization: 'Kindnesspassedon')
          expect(described_class.count).to eq 0
        end
      end
    end
  end

  describe '#ripples' do
    it 'returns all of its ripples' do
      tag = described_class.create(name: 'Columbus',
                                   description: Faker::Lorem.characters(number: 250), organization: 'Kindnesspassedon')
      tag.ripples << ripples
      expect(tag.ripples).to eq ripples
    end
  end

  describe '#approved' do
    it 'returns all approved tags' do
      approved_tags
      expect(described_class.approved).to eq approved_tags
    end
  end

  describe '#pending_approval' do
    it 'returns all tags pending approval' do
      pending_approval
      expect(described_class.pending_approval).to eq pending_approval
    end
  end

  describe '#denied' do
    it 'returns all denied tags' do
      denied
      expect(described_class.denied).to eq denied
    end
  end
end