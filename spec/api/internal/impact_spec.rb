# frozen_string_literal: true

require 'rails_helper'
require 'api_helper'

RSpec.describe '/impact', type: :request do
  let(:ponds) { create_list(:pond, 2, release: release) }
  let(:ripples) { create_list(:ripple, 25, pond: ponds.sample) }
  let(:organizations) { create_list(:organization, 2) }
  let(:release) { create(:release, organization: organizations.first) }

  before do
    ripples
    authorize_request
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get api_internal_impact_url
      expect(response).to be_successful
    end

    it 'renders impact' do
      get api_internal_impact_url
      expect(response.body).to eq(expected_response)
    end
  end

  def expected_response
    {
      ponds: Pond.count,
      largest_pond: Ripple.largest_pond,
      ripples: Ripple.count,
      international_ripples: Ripple.international.count,
      domestic_ripples: Ripple.domestic.count,
      releases: Release.count,
      average_release_size: Release.average_release_size,
      organizations: Organization.count,
    }.to_json
  end
end
