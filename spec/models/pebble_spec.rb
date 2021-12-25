# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pebble, type: :model do
  subject { described_class.new }

  let(:location) do
    {
      city: Faker::Address.city,
      region: Faker::Address.state,
      country: Faker::Address.country_code,
      postal_code: Faker::Address.postcode,
    }
  end
  let(:amount) { 3 }

  describe '#create' do
    describe 'with valid data' do
      it { is_expected.to validate_presence_of(:pebble_key) }
      it { is_expected.to validate_presence_of(:uuid) }

      it 'can create a pebble' do
        described_class.create(city: 'Columbus', region: 'Ohio', country: 'US')
        expect(described_class.count).to eq 1
      end

      it 'converts country code to name' do
        described_class.create(city: 'Columbus', region: 'Ohio', country: 'US')
        expect(described_class.last.country).to eq 'United States of America'
      end
    end

    describe 'with invalid' do
      describe 'pebble_key' do
        it 'length can NOT create a pebble' do
          described_class.create(pebble_key: 'akey')
          expect(described_class.count).to eq 0
        end

        it 'start can NOT create a pebble' do
          described_class.create(pebble_key: 'H-ABC123')
          expect(described_class.count).to eq 0
        end

        it 'type can NOT create a pebble' do
          described_class.create(pebble_key: 123)
          expect(described_class.count).to eq 0
        end
      end

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

  describe '#generate' do
    describe 'with valid arguments' do
      it 'creates pebble records' do
        described_class.generate(amount: amount, location: location)
        expect(described_class.count).to eq amount
      end

      it 'creates unique_pebble pebble records' do
        described_class.generate(amount: amount, location: location, unique_pebble_code: 'GN')
        expect(described_class.last.pebble_key).to include('P-GN')
      end
    end

    describe 'with invalid' do
      it 'unique_pebble_code can NOT create unique_pebble pebble records' do
        expect do
          described_class.generate(amount: amount, location: location, unique_pebble_code: 'LONG')
        end.to raise_error(Pebble::GenerationError)
      end

      it 'location can NOT create unique_pebble pebble records' do
        expect do
          described_class.generate(amount: amount, location: ['Im not a hash'],
                                   unique_pebble_code: 'MN')
        end.to raise_error(Pebble::GenerationError)
      end

      it 'amount can NOT create unique_pebble pebble records' do
        expect do
          described_class.generate(amount: 'L', location: location, unique_pebble_code: 'MN')
        end.to raise_error(Pebble::GenerationError)
      end

      it 'amount size can NOT create unique_pebble pebble records' do
        expect do
          described_class.generate(amount: 500, location: location, unique_pebble_code: 'MN')
        end.to raise_error(Pebble::GenerationError)
      end
    end
  end
end
