# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RipplesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/ripples').to route_to('ripples#index')
    end

    it 'routes to #new' do
      expect(get: '/ripples/new').to route_to('ripples#new')
    end

    it 'routes to #show' do
      expect(get: '/ripples/1').to route_to('ripples#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/ripples/1/edit').to route_to('ripples#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/ripples').to route_to('ripples#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/ripples/1').to route_to('ripples#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/ripples/1').to route_to('ripples#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/ripples/1').to route_to('ripples#destroy', id: '1')
    end
  end
end
