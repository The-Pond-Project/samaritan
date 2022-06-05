# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { build(:order) }

  describe '#create' do
    context 'with valid data' do
      it { is_expected.to validate_presence_of(:uuid) }
      it { is_expected.to validate_presence_of(:amount) }
      it { is_expected.to validate_presence_of(:address1) }
      it { is_expected.to validate_presence_of(:postal_code) }
      it { is_expected.to validate_presence_of(:region) }
      it { is_expected.to validate_presence_of(:city) }
      it { is_expected.to validate_presence_of(:country) }
      it { is_expected.to validate_length_of(:uuid).is_equal_to(36) }

      it 'can create a order' do
        expect(subject.save).to eq true
      end

      it 'can create a order without address2' do
        subject.address2 = nil
        expect(subject.save).to eq true
      end
    end
  end

  describe '#full_address' do
    it 'returns address1 city region and postal code as a string' do
      subject.address2 = nil
      expect(subject.full_address).to eq '123 main st, Columbus, Ohio 43235'
    end

    it 'returns address1 address2 city region and postal code as a string' do
      expect(subject.full_address).to eq '123 main st Apt 103, Columbus, Ohio 43235'
    end
  end
end
