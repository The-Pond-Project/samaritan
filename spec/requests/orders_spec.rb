# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/orders', type: :request do
  let(:order) { create(:order) }
  let(:new_order) { build(:order) }

  describe 'GET /show' do
    it 'renders a successful response' do
      get order_url(order)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_order_url(new_order)
      expect(response).to be_successful
    end
  end
end
