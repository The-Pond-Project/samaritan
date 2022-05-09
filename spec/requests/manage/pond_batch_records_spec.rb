# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/pond_batch_records', type: :request do
  let(:organization) { create(:organization, name: 'kindness passed on') }
  let(:release) { create(:release, organization: organization) }

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_manage_organization_release_pond_batch_record_url(organization.name, release.id)
      expect(response).to be_successful
    end
  end

  # describe 'POST /create' do
  #   context 'with valid parameters' do
  #     it 'creates a new PondBatchRecord' do
  #       expect do
  #         post pond_batch_records_url, params: { pond_batch_record: valid_attributes }
  #       end.to change { PondBatchRecord.count }.by(1)
  #     end

  #     it 'redirects to the created pond_batch_record' do
  #       post pond_batch_records_url, params: { pond_batch_record: valid_attributes }
  #       expect(response).to redirect_to(pond_batch_record_url(PondBatchRecord.last))
  #     end
  #   end

  #   context 'with invalid parameters' do
  #     it 'does not create a new PondBatchRecord' do
  #       expect do
  #         post pond_batch_records_url, params: { pond_batch_record: invalid_attributes }
  #       end.to change { PondBatchRecord.count }.by(0)
  #     end

  #     it "renders a successful response (i.e. to display the 'new' template)" do
  #       post pond_batch_records_url, params: { pond_batch_record: invalid_attributes }
  #       expect(response).to be_successful
  #     end
  #   end
  # end
end
