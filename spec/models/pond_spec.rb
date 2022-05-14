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
        context 'when length is invalid' do
          let(:pond) { create(:pond, key: 'akey', release: release) }

          it 'can NOT create a pond' do
            expect { pond }.to raise_error(ActiveRecord::RecordInvalid)
          end
        end

        context 'when start is invalid' do
          let(:pond) { create(:pond, key: 'H-ABC123', release: release) }

          it 'can NOT create a pond' do
            expect { pond }.to raise_error(ActiveRecord::RecordInvalid)
          end
        end

        context 'when type is invalid' do
          let(:pond) { create(:pond, key: 123, release: release) }

          it 'can NOT create a pond' do
            expect { pond }.to raise_error(ActiveRecord::RecordInvalid)
          end
        end
      end

      describe 'uuid' do
        context 'when there are no spaces' do
          let(:pond) { create(:pond, uuid: 'notlongenough', release: release) }

          it 'can NOT create a pond' do
            expect { pond }.to raise_error(ActiveRecord::RecordInvalid)
          end
        end

        context 'when length is invalid' do
          let(:pond) do
            create(:pond, uuid: '03729ea0r77a7t4596pa661u6148c8878b91', release: release)
          end

          it 'can NOT create a pond' do
            expect { pond }.to raise_error(ActiveRecord::RecordInvalid)
          end
        end

        context 'when type is invalid' do
          let(:pond) { create(:pond, uuid: 123, release: release) }

          it 'can NOT create a pond' do
            expect { pond }.to raise_error(ActiveRecord::RecordInvalid)
          end
        end
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
