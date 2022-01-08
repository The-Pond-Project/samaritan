# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/stories', type: :request do
  describe 'GET /new' do
    it 'renders a successful response' do
      get new_story_url
      expect(response).to be_successful
    end
  end

  # describe "POST /create" do
  #   context "with valid parameters" do
  #     it "creates a new Story" do
  #       expect {
  #         post stories_url, params: { story: valid_attributes }
  #       }.to change(Story, :count).by(1)
  #     end

  #     it "redirects to the created story" do
  #       post stories_url, params: { story: valid_attributes }
  #       expect(response).to redirect_to(story_url(Story.last))
  #     end
  #   end

  #   context "with invalid parameters" do
  #     it "does not create a new Story" do
  #       expect {
  #         post stories_url, params: { story: invalid_attributes }
  #       }.to change(Story, :count).by(0)
  #     end

  #     it "renders a successful response (i.e. to display the 'new' template)" do
  #       post stories_url, params: { story: invalid_attributes }
  #       expect(response).to be_successful
  #     end
  #   end
  # end
end
