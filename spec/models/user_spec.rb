# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class }

  describe '#create' do
    describe 'with valid data' do
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
end
