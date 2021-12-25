# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PebblesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/pebbles').to route_to('pebbles#index')
    end

    it 'routes to #new' do
      expect(get: '/pebbles/new').to route_to('pebbles#new')
    end

    it 'routes to #show' do
      expect(get: '/pebbles/1').to route_to('pebbles#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/pebbles/1/edit').to route_to('pebbles#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/pebbles').to route_to('pebbles#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/pebbles/1').to route_to('pebbles#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/pebbles/1').to route_to('pebbles#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/pebbles/1').to route_to('pebbles#destroy', id: '1')
    end
  end
end
