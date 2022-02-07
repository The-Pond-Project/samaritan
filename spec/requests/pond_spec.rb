# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/ponds', type: :request do
  let(:ponds) { create_list(:pond, 2) }
  let(:pond) { create(:pond) }

  describe 'GET /index' do
    it 'renders a successful response' do
      ponds
      get ponds_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get pond_url(pond)
      expect(response).to be_successful
    end
  end
end
