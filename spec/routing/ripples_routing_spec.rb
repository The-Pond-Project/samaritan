# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RipplesController, type: :routing do
  let(:uuid) { SecureRandom.uuid }

  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/ponds/P-ABC123/ripples').to route_to('ripples#index', pond_key: 'P-ABC123')
    end

    it 'routes to #new' do
      expect(get: '/ponds/P-ABC123/ripples/new').to route_to('ripples#new',
                                                             pond_key: 'P-ABC123')
    end

    it 'routes to #show' do
      expect(get: "/ponds/P-ABC123/ripples/#{uuid}") \
        .to route_to('ripples#show', uuid: uuid, pond_key: 'P-ABC123')
    end

    it 'routes to #create' do
      expect(post: '/ponds/P-ABC123/ripples').to route_to('ripples#create', pond_key: 'P-ABC123')
    end
  end
end
