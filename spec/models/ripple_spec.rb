# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.describe Ripple, type: :model do
  subject { described_class.new }

  let(:user) { create(:user) }
  let(:pond) { create(:pond) }
  let(:organization) { create(:organization) }
  let(:ripple) { create(:ripple, user: user, pond: pond) }
  let(:ripples) { create_list(:ripple, 3, user: user, pond: pond, country: 'US') }
  let(:international_ripples) { create_list(:ripple, 3, user: user, pond: pond, country: 'GB') }
  let(:tags) { create_list(:tag, 4, approved: true, organization: organization) }

  describe '#create' do
    context 'with valid data' do
      it { is_expected.to validate_presence_of(:uuid) }
      it { is_expected.to validate_presence_of(:pond_id) }
      it { is_expected.to validate_length_of(:uuid).is_equal_to(36) }

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

      it 'validates tag limit of 3' do
        ripple = described_class.create(pond: pond, user: user)
        ripple.update(tags: tags)
        expect(ripple.update(tags: tags)).to eq false
      end
    end

    context 'with invalid' do
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
    before do
      ripple
      ripples
    end

    it 'returns all ripples created after that instance that belong to the same pond' do
      expect(ripple.descendants).to match_array(ripples)
    end
  end

  describe '#ancestors' do
    before do
      ripples
      ripple
    end

    it 'returns all ripples created before that instance that belong to the same pond' do
      expect(ripple.ancestors).to match_array(ripples)
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

  describe '#address_changed?' do
    before do
      ripple
    end

    it 'true if country changed' do
      ripple.country = 'Changed Nation'
      expect(ripple.send(:address_changed?)).to eq true
    end

    it 'true if city changed' do
      ripple.city = 'Changed City'
      expect(ripple.send(:address_changed?)).to eq true
    end

    it 'true if postal_code changed' do
      ripple.postal_code = 'Changed Zip'
      expect(ripple.send(:address_changed?)).to eq true
    end

    it 'true if region changed' do
      ripple.region = 'Changed region'
      expect(ripple.send(:address_changed?)).to eq true
    end

    it 'true if longitude changed' do
      ripple.longitude = 'Changed longitude'
      expect(ripple.send(:address_changed?)).to eq true
    end

    it 'true if latitude changed' do
      ripple.latitude = 'Changed latitude'
      expect(ripple.send(:address_changed?)).to eq true
    end
  end

  describe '#address' do
    it 'includes country' do
      expect(ripple.address).to include(ripple.country)
    end

    it 'includes city' do
      expect(ripple.address).to include(ripple.city)
    end

    it 'includes postal_code' do
      expect(ripple.address).to include(ripple.postal_code)
    end

    it 'includes region' do
      expect(ripple.address).to include(ripple.region)
    end
  end

  describe '#to_param' do
    it 'returns uuid' do
      expect(ripple.to_param).to eq ripple.uuid
    end
  end

  describe '#ripple_since' do
    it 'returns human readable time since' do
      ripples
      pond.ripples.last.update(created_at: pond.ripples.last.created_at - 3.weeks)
      expect(described_class.ripple_since).to eq '3 weeks ago'
    end
  end

  describe '#largest_pond' do
    let(:pond_two) { create(:pond) }
    it 'returns uuid' do
      pond
      pond_two
      expect(described_class.largest_pond).to eq pond.ripples.count
    end
  end

  describe '#notify_text_subscribers' do
    let(:ripple) { build(:ripple, pond: pond) }

    it 'calls publisher' do
      Flipper.enable(:text_subscriptions)

      expect(Publishers::RippleCreated).to receive(:call).with(ripple)
      ripple.save
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
