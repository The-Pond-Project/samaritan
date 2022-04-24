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
      get new_manage_bill_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      get edit_manage_bill_url(bill)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    before do
      bill
    end
    context "with valid parameters" do
      it "creates a new Bill" do
        expect {
          post manage_bills_url, params: { bill: bill.attributes }
        }.to change(Bill, :count).by(1)
      end

      it "redirects to the created bill" do
        post manage_bills_url, params: { bill: bill.attributes }
        expect(response).to redirect_to(manage_bill_url(Bill.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Bill" do
        expect {
          post manage_bills_url, params: { bill: {trash: 'params'} }
        }.to_not change(Bill, :count)
      end

      it "renders an unprocessable_entity response (i.e. to display the 'new' template)" do
        post manage_bills_url, params: { bill: {trash: 'params'} }
        expect(response.code).to eq('422')
      end
    end
  end

  describe "PATCH /update" do
    before do
      bills
      @old_bill = bills.last
    end
    context "with valid parameters" do
      it "updates the requested bill" do
        patch manage_bill_url(@old_bill), params: { bill: bill.attributes }
        @old_bill.reload
        expect(@old_bill.name).to eq(bill.name)
      end

      it "redirects to the bill" do
        patch manage_bill_url(@old_bill), params: { bill: bill.attributes }
        @old_bill.reload
        expect(response).to redirect_to(manage_bill_url(@old_bill))
      end
    end

    # context "with invalid parameters" do
    #   it "renders a unprocessable_entity response (i.e. to display the 'edit' template)" do
    #     patch manage_bill_url(@old_bill), params: { bill: {expense_type: 822} }
    #     @old_bill.reload
    #     expect(response.code).to eq('422')
    #   end
    # end
  end

  describe "DELETE /destroy" do
    it "destroys the requested bill" do
      bill
      expect {
        delete manage_bill_url(bill)
      }.to change(Bill, :count).by(-1)
    end

    it "redirects to the bills list" do
      bill
      delete manage_bill_url(bill)
      expect(response).to redirect_to(manage_bills_url)
    end
  end
end
