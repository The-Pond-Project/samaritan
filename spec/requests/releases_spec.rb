# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/releases', type: :request do
  let(:organization) { create(:organization, name: 'kindnesspassedon') }
  let(:releases) { create_list(:release, 2, organization: organization) }
  let(:release) { create(:release, organization: organization) }

  describe 'GET /index' do
    it 'renders a successful response' do
      releases
      get organization_releases_path(organization)
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get organization_release_path(organization, release)
      expect(response).to be_successful
    end
  end
end
