# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/ripples', type: :request do
  let(:ripples) { create_list(:ripple, 2) }
  let(:pond) { create(:pond) }
  let(:ripple) { create(:ripple, pond: pond) }

  let(:valid_attributes) do
    { pond: pond }
  end

  let(:invalid_attributes) do
    { not_pond_id: 1 }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      ripples
      get pond_ripples_url(pond)
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get pond_ripple_url(pond, ripple)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_pond_ripple_url(pond)
      expect(response).to be_successful
    end
  end

  # describe "POST /create" do
  #   context "with valid parameters" do
  #     it "creates a new Ripple" do
  #       expect {
  #         get new_pond_ripple_url(pond.key)
  #         post ripples_url, params: { pond_key: pond.key, ripple: valid_attributes }
  #       }.to change(Ripple, :count).by(1)
  #     end

  #     it "redirects to the created ripple" do
  #       post ripples_url, params: { ripple: valid_attributes }
  #       expect(response).to redirect_to(ripple_url(Ripple.last.uuid))
  #     end
  #   end

  #   context "with invalid parameters" do
  #     it "does not create a new Ripple" do
  #       expect {
  #         post ripples_url, params: { ripple: invalid_attributes }
  #       }.to change(Ripple, :count).by(0)
  #     end

  #     it "renders a successful response (i.e. to display the 'new' template)" do
  #       post ripples_url, params: { ripple: invalid_attributes }
  #       expect(response).to be_successful
  #     end
  #   end
  # end

  # describe "DELETE /destroy" do
  #   it "destroys the requested ripple" do
  #     ripple = Ripple.create! valid_attributes
  #     expect {
  #       delete ripple_url(ripple)
  #     }.to change(Ripple, :count).by(-1)
  #   end

  #   it "redirects to the ripples list" do
  #     ripple = Ripple.create! valid_attributes
  #     delete ripple_url(ripple)
  #     expect(response).to redirect_to(ripples_url)
  #   end
  # end
end
