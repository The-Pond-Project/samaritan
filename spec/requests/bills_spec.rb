# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/bills', type: :request do
  let(:user) { create(:user, :super_admin) }
  let(:bills) { create_list(:bill, 2) }
  let(:bill) { create(:bill) }

  before do
    sign_in(user)
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      bills
      get manage_bills_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get manage_bill_url(bill)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_manage_bill_path(bill)
      expect(response).to be_successful
    end
  end

  # describe "GET /edit" do
  #   it "render a successful response" do
  #     bill = Bill.create! valid_attributes
  #     get edit_bill_url(bill)
  #     expect(response).to be_successful
  #   end
  # end

  # describe "POST /create" do
  #   context "with valid parameters" do
  #     it "creates a new Bill" do
  #       expect {
  #         post bills_url, params: { bill: valid_attributes }
  #       }.to change(Bill, :count).by(1)
  #     end

  #     it "redirects to the created bill" do
  #       post bills_url, params: { bill: valid_attributes }
  #       expect(response).to redirect_to(bill_url(Bill.last))
  #     end
  #   end

  #   context "with invalid parameters" do
  #     it "does not create a new Bill" do
  #       expect {
  #         post bills_url, params: { bill: invalid_attributes }
  #       }.to change(Bill, :count).by(0)
  #     end

  #     it "renders a successful response (i.e. to display the 'new' template)" do
  #       post bills_url, params: { bill: invalid_attributes }
  #       expect(response).to be_successful
  #     end
  #   end
  # end

  # describe "PATCH /update" do
  #   context "with valid parameters" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }

  #     it "updates the requested bill" do
  #       bill = Bill.create! valid_attributes
  #       patch bill_url(bill), params: { bill: new_attributes }
  #       bill.reload
  #       skip("Add assertions for updated state")
  #     end

  #     it "redirects to the bill" do
  #       bill = Bill.create! valid_attributes
  #       patch bill_url(bill), params: { bill: new_attributes }
  #       bill.reload
  #       expect(response).to redirect_to(bill_url(bill))
  #     end
  #   end

  #   context "with invalid parameters" do
  #     it "renders a successful response (i.e. to display the 'edit' template)" do
  #       bill = Bill.create! valid_attributes
  #       patch bill_url(bill), params: { bill: invalid_attributes }
  #       expect(response).to be_successful
  #     end
  #   end
  # end

  # describe "DELETE /destroy" do
  #   it "destroys the requested bill" do
  #     bill = Bill.create! valid_attributes
  #     expect {
  #       delete bill_url(bill)
  #     }.to change(Bill, :count).by(-1)
  #   end

  #   it "redirects to the bills list" do
  #     bill = Bill.create! valid_attributes
  #     delete bill_url(bill)
  #     expect(response).to redirect_to(bills_url)
  #   end
  # end
end
