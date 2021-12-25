# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/tags').to route_to('tags#index')
    end

    it 'routes to #new' do
      expect(get: '/tags/new').to route_to('tags#new')
    end

    it 'routes to #show' do
      expect(get: '/tags/kindnesspassedon').to route_to('tags#show', name: 'kindnesspassedon')
    end

    it 'routes to #create' do
      expect(post: '/tags').to route_to('tags#create')
    end

    it 'routes to #destroy' do
      expect(delete: '/tags/kindnesspassedon').to route_to('tags#destroy', name: 'kindnesspassedon')
    end
  end
end
