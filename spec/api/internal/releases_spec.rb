
# frozen_string_literal: true

require 'rails_helper'
require 'api_helper'

RSpec.describe '/releases', type: :request do
  let(:releases) { create_list(:release, 2) }
  let(:release) { create(:release) }

  before do 
    releases
    authorize_request
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get api_internal_releases_url
      expect(response).to be_successful
    end

    it 'renders a all releases' do
      get api_internal_releases_url
      expect(response.body).to eq(expected_response)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get api_internal_release_url(release.id)
      expect(response).to be_successful
    end

    it 'shows a release' do
      get api_internal_release_url(release.id)
      expect(response.body).to eq(::Internal::ReleaseSerializer.new(release).to_json)
    end
  end

  def expected_response 
    releases.map do |release|
      ::Internal::ReleaseSerializer.new(release)
    end.to_json
  end
end
