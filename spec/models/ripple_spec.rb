# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ripple, type: :model do
  subject { described_class.new }

  let(:user) { create(:user) }
  let(:pebble) { create(:pebble) }
  let(:ripple) { create(:ripple, user: user, pebble: pebble) }
  let(:ripples) { create_list(:ripple, 3, user: user, pebble: pebble) }

  describe '#create' do
    describe 'with valid data' do
      it { is_expected.to validate_presence_of(:uuid) }
      it { is_expected.to validate_presence_of(:pebble_id) }

      it 'can create a pebble' do
        described_class.create(city: 'Columbus', country: 'US', pebble: pebble, user: user)
        expect(described_class.count).to eq 1
      end

      it 'can create a pebble without a location' do
        described_class.create(pebble: pebble)
        expect(described_class.count).to eq 1
      end

      it 'can create a pebble without a user' do
        described_class.create(city: 'Columbus', country: 'US', pebble: pebble)
        expect(described_class.count).to eq 1
      end

      it 'converts country code to name' do
        described_class.create(city: 'Columbus', country: 'US', pebble: pebble, user: user)
        expect(described_class.last.country).to eq 'United States of America'
      end

      it 'converts nil city to unknown' do
        described_class.create(pebble: pebble, user: user)
        expect(described_class.last.city).to eq 'Unknown'
      end

      it 'converts nil country to unknown' do
        described_class.create(pebble: pebble, user: user)
        expect(described_class.last.country).to eq 'Unknown'
      end

      it 'converts nil region to unknown' do
        described_class.create(pebble: pebble, user: user)
        expect(described_class.last.region).to eq 'Unknown'
      end

      it 'converts nil postal_code to unknown' do
        described_class.create(pebble: pebble, user: user)
        expect(described_class.last.postal_code).to eq 'Unknown'
      end
    end

    describe 'with invalid' do
      describe 'uuid' do
        it 'length can NOT create a pebble' do
          described_class.create(uuid: 'notlongenough')
          expect(described_class.count).to eq 0
        end

        it 'can NOT create a pebble' do
          described_class.create(uuid: '03729ea0r77a7t4596pa661u6148c8878b91')
          expect(described_class.count).to eq 0
        end

        it 'type can NOT create a pebble' do
          described_class.create(uuid: 123)
          expect(described_class.count).to eq 0
        end
      end
    end
  end

  describe '#ripples_since' do
    it 'returns all ripples created after that instance that belong to the same pebble' do
      ripple
      ripples
      expect(ripple.ripples_since).to eq ripples
    end
  end

  describe '#domestic?' do
    it 'true if country is America' do
      expect(ripple.domestic?).to eq true
    end

    it 'false if country is America' do
      ripple.update(country: 'GB')
      expect(ripple.domestic?).to eq false
    end
  end
end
