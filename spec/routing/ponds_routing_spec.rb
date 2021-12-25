# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PondsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/ponds').to route_to('ponds#index')
    end

    it 'routes to #show' do
      expect(get: '/ponds/P-ABC123').to route_to('ponds#show', key: 'P-ABC123')
    end
  end
end
