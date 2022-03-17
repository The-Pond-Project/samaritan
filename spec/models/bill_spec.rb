# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bill, type: :model do
  let(:bill) { create(:bill) }
  describe '#create' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:due_at) }
    it { is_expected.to validate_presence_of(:recurrence) }
    it { is_expected.to validate_presence_of(:expense_type) }
    it { is_expected.to validate_length_of(:name).is_at_least(5).is_at_most(45) }
    it { is_expected.to validate_length_of(:description).is_at_least(5).is_at_most(350) }

    context 'with valid data' do
      it 'can create a bill' do
        bill
        expect(described_class.count).to eq 1
      end
    end
  end
end
