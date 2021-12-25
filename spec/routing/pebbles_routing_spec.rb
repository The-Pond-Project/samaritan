# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PebblesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/pebbles').to route_to('pebbles#index')
    end

    it 'routes to #show' do
      expect(get: '/pebbles/P-ABC123').to route_to('pebbles#show', pebble_key: 'P-ABC123')
    end
  end
end
