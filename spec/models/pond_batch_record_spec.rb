# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PondBatchRecord, type: :model do
  subject { described_class.new }

  let(:release) { create(:release) }

  describe '#create' do
    describe 'with valid data' do
      it { is_expected.to validate_presence_of(:amount) }
    end
  end
end
