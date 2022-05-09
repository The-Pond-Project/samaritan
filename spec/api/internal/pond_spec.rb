# frozen_string_literal: true

require 'rails_helper'
require 'api_helper'

RSpec.describe '/ponds', type: :request do
  let(:ponds) { create_list(:pond, 2) }
  let(:pond) { create(:pond) }

  before do
    ponds
    authorize_request
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get api_internal_ponds_url
      expect(response).to be_successful
    end

    it 'renders a all ponds' do
      get api_internal_ponds_url
      expect(response.body).to eq(expected_response)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get api_internal_pond_url(pond.id)
      expect(response).to be_successful
    end

    it 'shows a pond' do
      get api_internal_pond_url(pond.id)
      expect(response.body).to eq(::Internal::PondSerializer.new(pond).to_json)
    end
  end

  def expected_response
    ponds.map do |pond|
      ::Internal::PondSerializer.new(pond)
    end.to_json
  end
end
