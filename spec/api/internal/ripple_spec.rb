# frozen_string_literal: true

require 'rails_helper'
require 'api_helper'

RSpec.describe '/ripples', type: :request do
  let(:ripples) { create_list(:ripple, 2) }
  let(:ripple) { create(:ripple) }

  before do
    ripples
    authorize_request
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get api_internal_ripples_url
      expect(response).to be_successful
    end

    it 'renders a all ripples' do
      get api_internal_ripples_url
      expect(response.body).to eq(expected_response)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get api_internal_ripple_url(ripple.id)
      expect(response).to be_successful
    end

    it 'shows a ripple' do
      get api_internal_ripple_url(ripple.id)
      expect(response.body).to eq(::Internal::RippleSerializer.new(ripple).to_json)
    end
  end

  def expected_response
    ripples.map do |ripple|
      ::Internal::RippleSerializer.new(ripple)
    end.to_json
  end
end
