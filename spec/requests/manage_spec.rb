# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Manages', type: :request do
  let(:user) { create(:user, :super_admin) }

  before do
    sign_in(user)
  end

  describe 'GET /ripples' do
    it 'returns http success' do
      get '/manage/ripples'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /tags' do
    it 'returns http success' do
      get '/manage/tags'
      expect(response).to have_http_status(:success)
    end
  end
end
