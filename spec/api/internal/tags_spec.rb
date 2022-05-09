# frozen_string_literal: true

require 'rails_helper'
require 'api_helper'

RSpec.describe '/tags', type: :request do
  let(:tags) { create_list(:tag, 2, approved: true) }
  let(:tag) { create(:tag) }

  before do
    tags
    authorize_request
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get api_internal_tags_url
      expect(response).to be_successful
    end

    it 'renders a all tags' do
      get api_internal_tags_url
      expect(response.body).to eq(expected_response)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get api_internal_tag_url(tag.id)
      expect(response).to be_successful
    end

    it 'shows a tag' do
      get api_internal_tag_url(tag.id)
      expect(response.body).to eq(::Internal::TagSerializer.new(tag).to_json)
    end
  end

  def expected_response
    tags.map do |tag|
      ::Internal::TagSerializer.new(tag)
    end.to_json
  end
end
