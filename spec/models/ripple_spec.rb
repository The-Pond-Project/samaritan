# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ripple, type: :model do
  subject { described_class.new }

  let(:user) { create(:user) }
  let(:pond) { create(:pond) }
  let(:ripple) { create(:ripple, user: user, pond: pond) }
  let(:ripples) { create_list(:ripple, 3, user: user, pond: pond, country: 'US') }
  let(:international_ripples) { create_list(:ripple, 3, user: user, pond: pond, country: 'GB') }

  describe '#create' do
    describe 'with valid data' do
      it { is_expected.to validate_presence_of(:uuid) }
      it { is_expected.to validate_presence_of(:pond_id) }

      it 'can create a pond' do
        described_class.create(city: 'Columbus', country: 'US', pond: pond, user: user)
        expect(described_class.count).to eq 1
      end

      it 'can create a pond without a location' do
        described_class.create(pond: pond)
        expect(described_class.count).to eq 1
      end

      it 'can create a pond without a user' do
        described_class.create(city: 'Columbus', country: 'US', pond: pond)
        expect(described_class.count).to eq 1
      end

      it 'converts country code to name' do
        described_class.create(city: 'Columbus', country: 'US', pond: pond, user: user)
        expect(described_class.last.country).to eq 'United States of America'
      end

      it 'converts nil city to unknown' do
        described_class.create(pond: pond, user: user)
        expect(described_class.last.city).to eq 'Unknown'
      end

      it 'converts nil country to unknown' do
        described_class.create(pond: pond, user: user)
        expect(described_class.last.country).to eq 'Unknown'
      end

      it 'converts nil region to unknown' do
        described_class.create(pond: pond, user: user)
        expect(described_class.last.region).to eq 'Unknown'
      end

      it 'converts nil postal_code to unknown' do
        described_class.create(pond: pond, user: user)
        expect(described_class.last.postal_code).to eq 'Unknown'
      end
    end

    describe 'with invalid' do
      describe 'uuid' do
        it 'length can NOT create a ripple' do
          described_class.create(uuid: 'notlongenough')
          expect(described_class.count).to eq 0
        end

        it 'can NOT create a ripple' do
          described_class.create(uuid: '03729ea0r77a7t4596pa661u6148c8878b91')
          expect(described_class.count).to eq 0
        end

        it 'type can NOT create a ripple' do
          described_class.create(uuid: 123)
          expect(described_class.count).to eq 0
        end
      end
    end
  end

  describe '#descendants' do
    it 'returns all ripples created after that instance that belong to the same pond' do
      ripple
      ripples
      expect(ripple.descendants).to eq ripples
    end
  end

  describe '#ancestors' do
    it 'returns all ripples created before that instance that belong to the same pond' do
      ripples
      ripple
      expect(ripple.ancestors).to eq ripples
    end
  end

  describe '#impact' do
    it 'returns an integer count of all the ripples since' do
      ripple
      ripples
      expect(ripple.impact).to eq ripples.count
    end
  end

  describe '#domestic_impact' do
    it 'returns an integer count of all domestic the ripples since' do
      ripple
      ripples
      expect(ripple.domestic_impact).to eq ripples.count
    end
  end

  describe '#international_impact' do
    it 'returns an integer count of all domestic the ripples since' do
      ripple
      international_ripples
      expect(ripple.international_impact).to eq international_ripples.count
    end
  end

  describe '#last_descendant' do
    it 'returnsthe last descendant' do
      ripple
      ripples
      expect(ripple.last_descendant).to eq ripples.last
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
