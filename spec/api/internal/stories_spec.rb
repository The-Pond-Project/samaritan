# frozen_string_literal: true

require 'rails_helper'
require 'api_helper'

RSpec.describe '/stories', type: :request do
  let(:stories) { create_list(:story, 2) }
  let(:story) { create(:story) }

  before do 
    stories
    authorize_request
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get api_internal_stories_url
      expect(response).to be_successful
    end

    it 'renders a all stories' do
      get api_internal_stories_url
      expect(response.body).to eq(expected_response)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get api_internal_story_url(story.id)
      expect(response).to be_successful
    end

    it 'shows a story' do
      get api_internal_story_url(story.id)
      expect(response.body).to eq(::Internal::StorySerializer.new(story).to_json)
    end
  end

  def expected_response 
    stories.map do |story|
      ::Internal::StorySerializer.new(story)
    end.to_json
  end
end
