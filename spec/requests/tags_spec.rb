# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/tags', type: :request do

  let(:tags) { create_list(:tag, 3) }
  let(:tag) { create(:tag) }

  describe 'GET /index' do
    it 'renders a successful response' do
      tags
      get tags_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get tag_url(tag)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_tag_url
      expect(response).to be_successful
    end
  end

  # describe 'POST /create' do
  #   context 'with valid parameters' do
  #     it 'creates a new Tag' do
  #       expect do
  #         post tags_url, params: { tag: valid_attributes }
  #       end.to change { Tag.count }.by(1)
  #     end

  #     it 'redirects to the created tag' do
  #       post tags_url, params: { tag: valid_attributes }
  #       expect(response).to redirect_to(tag_url(Tag.last))
  #     end
  #   end

  #   context 'with invalid parameters' do
  #     it 'does not create a new Tag' do
  #       expect do
  #         post tags_url, params: { tag: invalid_attributes }
  #       end.to change { Tag.count }.by(0)
  #     end

  #     it "renders a successful response (i.e. to display the 'new' template)" do
  #       post tags_url, params: { tag: invalid_attributes }
  #       expect(response).to be_successful
  #     end
  #   end
  # end

  # describe 'DELETE /destroy' do
  #   it 'destroys the requested tag' do
  #     tag = Tag.create! valid_attributes
  #     expect do
  #       delete tag_url(tag)
  #     end.to change { Tag.count }.by(-1)
  #   end

  #   it 'redirects to the tags list' do
  #     tag = Tag.create! valid_attributes
  #     delete tag_url(tag)
  #     expect(response).to redirect_to(tags_url)
  #   end
  # end
end
