# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/pebbles', type: :request do

  let(:pebbles) { create_list(:pebble, 2) }
  let(:pebble) { create(:pebble) }


  describe 'GET /index' do
    it 'renders a successful response' do
      pebbles
      get pebbles_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get pebble_url(pebble.key)
      expect(response).to be_successful
    end
  end
end
