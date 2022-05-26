# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/donations', type: :request do
  let(:valid_params) do
    { amount: 2, email: 'ohthatsanemailemail@gmail.com', format: 'js' }
  end

  let(:invalid_params) do
    { amount: 0, email: 'ohthatsanemailemail@gmail.com', format: 'js' }
  end
  before { StripeMock.start }

  after { StripeMock.stop }

  describe 'post /create' do
    context 'when given valid params' do
      it 'renders a successful response' do
        post donations_url, params: valid_params
        expect(response).to be_successful
      end
    end

    context 'when given invalid params' do
      it 'renders a successful response' do
        post donations_url, params: invalid_params
        expect(response).to redirect_to(donate_path)
        expect(flash[:alert]).to match('Please enter an amount of at least $1.')
      end
    end
  end
end
