# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pages', type: :request do
  describe 'GET /' do
    it 'returns http success' do
      get '/'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /ripples' do
    it 'returns http success' do
      get '/ripples'
      expect(response).to have_http_status(:success)
    end
  end
end
