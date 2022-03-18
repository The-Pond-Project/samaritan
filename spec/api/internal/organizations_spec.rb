# frozen_string_literal: true

require 'rails_helper'
require 'api_helper'

RSpec.describe '/organizations', type: :request do
  let(:organizations) { create_list(:organization, 2) }
  let(:organization) { create(:organization) }

  before do 
    organizations
    authorize_request
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get api_internal_organizations_url
      expect(response).to be_successful
    end

    it 'renders a all organizations' do
      get api_internal_organizations_url
      expect(response.body).to eq(expected_response)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get api_internal_organization_url(organization.id)
      expect(response).to be_successful
    end

    it 'shows a organization' do
      get api_internal_organization_url(organization.id)
      expect(response.body).to eq(::Internal::OrganizationSerializer.new(organization).to_json)
    end
  end

  def expected_response 
    organizations.map do |organization|
      ::Internal::OrganizationSerializer.new(organization)
    end.to_json
  end
end
