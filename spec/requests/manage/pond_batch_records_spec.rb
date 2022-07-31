# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Layout/LineLength
RSpec.describe '/pond_batch_records', type: :request do
  let(:organization) { create(:organization, name: 'kindness passed on') }
  let(:release) { create(:release, organization: organization) }
  let(:user) { create(:user, :super_admin) }
  let(:valid_attributes) do
    {
      organization_name: organization.name,
      release_id: release.id,
      amount: 1,
    }
  end
  let(:invalid_attributes) do
    {
      organization_name: organization.name,
      release_id: release.id,
    }
  end

  before do
    sign_in(user)
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_manage_organization_release_pond_batch_record_url(organization.name, release.id)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new PondBatchRecord' do
        expect do
          post manage_organization_release_pond_batch_record_index_url(organization.name, release.id),
               params: valid_attributes
        end.to change { PondBatchRecord.count }.by(1)
      end

      # FIX ME: Errno::EACCES:Permission denied @ rb_file_s_rename

      # it 'redirects to the created pond_batch_record' do
      #   post manage_organization_release_pond_batch_record_index_url(organization.name, release.id),
      #        params: valid_attributes
      #   expect(response).to redirect_to(manage_organization_release_path(organization.name,
      #                                                                    release))
      # end
    end

    context 'with invalid parameters' do
      it 'does not create a new PondBatchRecord' do
        expect do
          post manage_organization_release_pond_batch_record_index_url(organization.name, release.id),
               params: invalid_attributes
        end.to change { PondBatchRecord.count }.by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post manage_organization_release_pond_batch_record_index_url(organization.name, release.id),
             params: invalid_attributes
        expect(response).to be_unprocessable
      end
    end
  end
end
# rubocop:enable Layout/LineLength
