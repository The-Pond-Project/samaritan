# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Organization, type: :model do
  let(:organization) { create(:organization) }
  describe '#create' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { should validate_length_of(:name).is_at_least(5).is_at_most(45) }
    it { should validate_length_of(:description).is_at_least(5).is_at_most(350) }

    context 'with valid data' do
      it 'can create a organization' do
        organization
        expect(described_class.count).to eq 1
      end
    end

    context 'with invalid' do
      describe 'file type' do
        not_image = Rack::Test::UploadedFile.new('spec/fixtures/kindnesspassedon.txt', 'txt')
        let(:organization) { create(:organization, image: not_image) }
        it 'does not create' do
          expect { organization }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end

      describe 'website' do
        let(:organization) { create(:organization, website: junk) }
        it 'does not create' do
          expect { organization }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end
  end

  describe '#to_param' do 
    it 'returns name' do
      organization
      expect(organization.to_param).to eq organization.name
    end
  end
end
