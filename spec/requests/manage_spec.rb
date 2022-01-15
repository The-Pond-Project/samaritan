# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Manages', type: :request do
  describe 'GET /ripples' do
    it 'returns http success' do
      get '/manage/ripples'
      expect(response).to have_http_status(:success)
    end
  end
end
