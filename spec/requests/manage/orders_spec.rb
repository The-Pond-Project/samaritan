# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/manage/orders', type: :request do
  let(:order) { create(:order) }
  let(:new_order) { build(:order) }
  let(:user) { create(:user, :super_admin) }

  before do
    sign_in(user)
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get manage_orders_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get manage_order_url(order)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_manage_order_url(new_order)
      expect(response).to be_successful
    end
  end
end
