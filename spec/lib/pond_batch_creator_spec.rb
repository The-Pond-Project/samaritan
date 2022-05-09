# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PondBatchCreator do
  let(:organization) { create(:organization) }
  let(:release) { create(:release, organization: organization) }
  let(:location) do
    { postal_code: 43_205, city: 'Columbus', region: 'Ohio', country: 'United States of America' }
  end

  describe '#execute' do
    context 'with minimal params' do
      it 'creates a pond' do
        expect { described_class.new(release_id: release.id).create_ponds }.to change {
                                                                                 Pond.count
                                                                               }.by 1
      end

      it 'creates a pond batch record' do
        expect { described_class.new(release_id: release.id).create_ponds }.to change {
                                                                                 PondBatchRecord.count
                                                                               }.by 1
        expect(PondBatchRecord.last.csv_file.attached?).to eq(true)
      end
    end

    context 'with multiple params' do
      it 'creates a pond batch record' do
        expect do
          described_class.new(
            release_id: release.id,
            location: location,
            unique_code: 'ML',
            amount: 1
          ).create_ponds
        end.to change { PondBatchRecord.count }.by 1
        expect(PondBatchRecord.last.csv_file.attached?).to eq(true)
      end

      it 'creates a pond' do
        expect do
          described_class.new(
            release_id: release.id,
            location: location,
            unique_code: 'ML',
            amount: 1
          ).create_ponds
        end.to change { Pond.count }.by 1
      end

      it 'creates 250 ponds' do
        expect do
          described_class.new(
            release_id: release.id,
            location: location,
            amount: 250
          ).create_ponds
        end.to change { Pond.count }.by 250
      end

      it 'creates unique pond' do
        expect do
          described_class.new(
            release_id: release.id,
            unique_code: 'ML'
          ).create_ponds
        end.to change { Pond.count }.by 1
        expect(Pond.last.key).to include('ML')
      end

      it 'creates pond with specific location' do
        expect do
          described_class.new(
            release_id: release.id,
            location: location
          ).create_ponds
        end.to change { Pond.count }.by 1
        expect(Pond.last.region).to eq('Ohio')
        expect(Pond.last.city).to eq('Columbus')
        expect(Pond.last.country).to eq('United States of America')
        expect(Pond.last.postal_code).to eq('43205')
      end
    end

    context 'with the wrong params' do
      context 'amount is too high' do
        it 'raises pond creation error' do
          creator = described_class.new(
            release_id: release.id,
            amount: 1001
          )
          creator.create_ponds
          expect(creator.errors).to include('Amount must be lower than 1000')
        end
      end

      context 'amount is not greater than or equal to 1' do
        it 'raises pond creation error' do
          creator = described_class.new(
            release_id: release.id,
            amount: '-5'
          )
          creator.create_ponds
          expect(creator.errors).to include('Amount can not be lower than 0')
        end
      end

      context 'release_id is not an integer' do
        it 'raises pond creation error' do
          creator = described_class.new(
            release_id: release.id.to_s,
            location: 'location'
          )
          creator.create_ponds
          expect(creator.errors).to include('Release must be a String')
        end
      end

      context 'release_id does not belong to a record in the database' do
        it 'raises pond creation error' do
          creator = described_class.new(
            release_id: 12_345_678_980
          )
          creator.create_ponds
          expect(creator.errors).to include('Release not found!')
        end
      end
    end
  end
end
