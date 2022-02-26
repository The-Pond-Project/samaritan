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
  let(:release) { create(:release) }
  let(:pond) { create(:pond, country: 'US', release: release) }
  let(:ripples) { create_list(:ripple, 3, pond: pond, country: 'US') }
  let(:international_ripples) { create_list(:ripple, 3, pond: pond, country: 'GB') }

  describe '#create' do
    describe 'with valid data' do
      before do
        pond
      end

      it { is_expected.to validate_presence_of(:key) }
      it { is_expected.to validate_presence_of(:uuid) }
      it { is_expected.to validate_length_of(:key).is_equal_to(8) }
      it { is_expected.to validate_length_of(:uuid).is_equal_to(36) }

      it 'can create a pond' do
        expect(described_class.count).to eq 1
      end

      it 'converts country code to name' do
        expect(described_class.last.country).to eq 'United States of America'
      end
    end

    describe 'with invalid' do
      describe 'key' do
        context 'length' do
          let(:pond) { create(:pond, key: 'akey', release: release) }

          it 'can NOT create a pond' do
            expect { pond }.to raise_error(ActiveRecord::RecordInvalid)
          end
        end

        context 'start' do
          let(:pond) { create(:pond, key: 'H-ABC123', release: release) }

          it 'can NOT create a pond' do
            expect { pond }.to raise_error(ActiveRecord::RecordInvalid)
          end
        end

        context 'type' do
          let(:pond) { create(:pond, key: 123, release: release) }

          it 'can NOT create a pond' do
            expect { pond }.to raise_error(ActiveRecord::RecordInvalid)
          end
        end
      end

      describe 'uuid' do
        context 'spaces' do
          let(:pond) { create(:pond, uuid: 'notlongenough', release: release) }

          it 'can NOT create a pond' do
            expect { pond }.to raise_error(ActiveRecord::RecordInvalid)
          end
        end

        context 'length' do
          let(:pond) do
            create(:pond, uuid: '03729ea0r77a7t4596pa661u6148c8878b91', release: release)
          end

          it 'can NOT create a pond' do
            expect { pond }.to raise_error(ActiveRecord::RecordInvalid)
          end
        end

        context 'type' do
          let(:pond) { create(:pond, uuid: 123, release: release) }

          it 'can NOT create a pond' do
            expect { pond }.to raise_error(ActiveRecord::RecordInvalid)
          end
        end
      end
    end
  end

  describe '#generate' do
    describe 'with valid arguments' do
      it 'creates pond records' do
        described_class.generate(amount: amount, location: location, release_id: release.id)
        expect(described_class.count).to eq amount
      end

      it 'creates unique_pond pond records' do
        described_class.generate(amount: amount, location: location, unique_pond_code: 'GN',
                                 release_id: release.id)
        expect(described_class.last.key).to include('P-GN')
      end
    end

    describe 'with invalid' do
      it 'unique_pond_code can NOT create unique_pond pond records' do
        expect do
          described_class.generate(amount: amount, location: location, unique_pond_code: 'LONG',
                                   release_id: release.id)
        end.to raise_error(Pond::GenerationError)
      end

      it 'location can NOT create unique_pond pond records' do
        expect do
          described_class.generate(amount: amount, location: ['Im not a hash'],
                                   unique_pond_code: 'MN', release_id: release.id)
        end.to raise_error(Pond::GenerationError)
      end

      it 'amount can NOT create unique_pond pond records' do
        expect do
          described_class.generate(amount: 'L', location: location, unique_pond_code: 'MN',
                                   release_id: release.id)
        end.to raise_error(Pond::GenerationError)
      end

      it 'amount size can NOT create unique_pond pond records' do
        expect do
          described_class.generate(amount: 500, location: location, unique_pond_code: 'MN',
                                   release_id: release.id)
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

  describe '#impact' do
    it 'returns pond impact' do
      expect(pond.impact).to eq pond.ripples.count
    end
  end

  describe '#domestic_impact' do
    it 'returns pond impact' do
      expect(pond.domestic_impact).to eq pond.ripples.count
    end
  end

  describe '#international_impact' do
    it 'returns pond impact' do
      expect(pond.international_impact).to eq pond.ripples.count
    end
  end

  describe '#last_ripple' do
    it 'returns pond impact' do
      expect(pond.last_ripple).to eq pond.ripples.last
    end
  end

  describe '#to_param' do
    it 'returns key' do
      expect(pond.to_param).to eq pond.key
    end
  end

  describe '#ripple_since' do
    it 'returns human readable time since' do
      ripples
      pond.ripples.last.update(created_at: pond.ripples.last.created_at - 3.weeks)
      expect(pond.ripple_since).to eq '3 weeks ago'
    end
  end
end
