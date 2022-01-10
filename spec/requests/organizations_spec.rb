# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/organizations', type: :request do
  let(:organizations) { create_list(:organization, 2) }
  let(:organization) { create(:organization) }

  let(:valid_attributes) do
    { organization: organization }
  end

  let(:invalid_attributes) do
    { not_organization_id: 1 }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      organizations
      get organizations_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    let(:organization) { create(:organization, name: 'KindnessPassedOn') }
    it 'renders a successful response' do
      get organization_url(organization.name)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_organization_url
      expect(response).to be_successful
    end
  end

  # describe "GET /edit" do
  #   it "render a successful response" do
  #     organization = Organization.create! valid_attributes
  #     get edit_organization_url(organization)
  #     expect(response).to be_successful
  #   end
  # end

  # describe "POST /create" do
  #   context "with valid parameters" do
  #     it "creates a new Organization" do
  #       expect {
  #         post organizations_url, params: { organization: valid_attributes }
  #       }.to change(Organization, :count).by(1)
  #     end

  #     it "redirects to the created organization" do
  #       post organizations_url, params: { organization: valid_attributes }
  #       expect(response).to redirect_to(organization_url(Organization.last))
  #     end
  #   end

  #   context "with invalid parameters" do
  #     it "does not create a new Organization" do
  #       expect {
  #         post organizations_url, params: { organization: invalid_attributes }
  #       }.to change(Organization, :count).by(0)
  #     end

  #     it "renders a successful response (i.e. to display the 'new' template)" do
  #       post organizations_url, params: { organization: invalid_attributes }
  #       expect(response).to be_successful
  #     end
  #   end
  # end

  # describe "PATCH /update" do
  #   context "with valid parameters" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }

  #     it "updates the requested organization" do
  #       organization = Organization.create! valid_attributes
  #       patch organization_url(organization), params: { organization: new_attributes }
  #       organization.reload
  #       skip("Add assertions for updated state")
  #     end

  #     it "redirects to the organization" do
  #       organization = Organization.create! valid_attributes
  #       patch organization_url(organization), params: { organization: new_attributes }
  #       organization.reload
  #       expect(response).to redirect_to(organization_url(organization))
  #     end
  #   end

  #   context "with invalid parameters" do
  #     it "renders a successful response (i.e. to display the 'edit' template)" do
  #       organization = Organization.create! valid_attributes
  #       patch organization_url(organization), params: { organization: invalid_attributes }
  #       expect(response).to be_successful
  #     end
  #   end
  # end

  # describe "DELETE /destroy" do
  #   it "destroys the requested organization" do
  #     organization = Organization.create! valid_attributes
  #     expect {
  #       delete organization_url(organization)
  #     }.to change(Organization, :count).by(-1)
  #   end

  #   it "redirects to the organizations list" do
  #     organization = Organization.create! valid_attributes
  #     delete organization_url(organization)
  #     expect(response).to redirect_to(organizations_url)
  #   end
  # end
end
