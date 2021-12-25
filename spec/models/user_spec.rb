# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new }

  let(:user) { create(:user, email: 'testusername@email.com') }

  describe '#create' do
    describe 'with valid data' do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:password) }

      it 'can create a user' do
        described_class.create(email: 'myemail@email.com', password: 'password')
        expect(described_class.count).to eq 1
      end
    end

    describe 'with invalid' do
      it 'email' do
        described_class.create(email: 'notanemail', password: 'password')
        expect(described_class.count).to eq 0
      end

      it 'password' do
        described_class.create(email: 'myemail@email.com', password: 'short')
        expect(described_class.count).to eq 0
      end
    end
  end

  describe '#username' do 
    it 'returns the beginning of a users email' do 
      expect(user.username).to eq 'testusername'
    end
  end
end
