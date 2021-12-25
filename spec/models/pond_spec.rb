# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pond, type: :model do
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
  let(:pond) { create(:pond) }

  describe '#create' do
    describe 'with valid data' do
      it { is_expected.to validate_presence_of(:key) }
      it { is_expected.to validate_presence_of(:uuid) }

      it 'can create a pond' do
        described_class.create(city: 'Columbus', region: 'Ohio', country: 'US')
        expect(described_class.count).to eq 1
      end

      it 'converts country code to name' do
        described_class.create(city: 'Columbus', region: 'Ohio', country: 'US')
        expect(described_class.last.country).to eq 'United States of America'
      end
    end

    describe 'with invalid' do
      describe 'key' do
        it 'length can NOT create a pond' do
          described_class.create(key: 'akey')
          expect(described_class.count).to eq 0
        end

        it 'start can NOT create a pond' do
          described_class.create(key: 'H-ABC123')
          expect(described_class.count).to eq 0
        end

        it 'type can NOT create a pond' do
          described_class.create(key: 123)
          expect(described_class.count).to eq 0
        end
      end

      describe 'uuid' do
        it 'length can NOT create a pond' do
          described_class.create(uuid: 'notlongenough')
          expect(described_class.count).to eq 0
        end

        it 'can NOT create a pond' do
          described_class.create(uuid: '03729ea0r77a7t4596pa661u6148c8878b91')
          expect(described_class.count).to eq 0
        end

        it 'type can NOT create a pond' do
          described_class.create(uuid: 123)
          expect(described_class.count).to eq 0
        end
      end
    end
  end

  describe '#generate' do
    describe 'with valid arguments' do
      it 'creates pond records' do
        described_class.generate(amount: amount, location: location)
        expect(described_class.count).to eq amount
      end

      it 'creates unique_pond pond records' do
        described_class.generate(amount: amount, location: location, unique_pond_code: 'GN')
        expect(described_class.last.key).to include('P-GN')
      end
    end

    describe 'with invalid' do
      it 'unique_pond_code can NOT create unique_pond pond records' do
        expect do
          described_class.generate(amount: amount, location: location, unique_pond_code: 'LONG')
        end.to raise_error(Pond::GenerationError)
      end

      it 'location can NOT create unique_pond pond records' do
        expect do
          described_class.generate(amount: amount, location: ['Im not a hash'],
                                   unique_pond_code: 'MN')
        end.to raise_error(Pond::GenerationError)
      end

      it 'amount can NOT create unique_pond pond records' do
        expect do
          described_class.generate(amount: 'L', location: location, unique_pond_code: 'MN')
        end.to raise_error(Pond::GenerationError)
      end

      it 'amount size can NOT create unique_pond pond records' do
        expect do
          described_class.generate(amount: 500, location: location, unique_pond_code: 'MN')
        end.to raise_error(Pond::GenerationError)
      end
    end
  end

  describe '#domestic?' do
    it 'true if country is America' do
      expect(pond.domestic?).to eq true
    end

    it 'false if country is America' do
      pond.update(country: 'GB')
      expect(pond.domestic?).to eq false
    end
  end
end
