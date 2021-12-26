# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RipplesController, type: :routing do
  let(:uuid) { SecureRandom.uuid }

  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/ripples').to route_to('ripples#index')
    end

    it 'routes to #new' do
      expect(get: '/ponds/P-ABC123/ripples/new').to route_to('ripples#new',
                                                             key: 'P-ABC123')
    end

    it 'routes to #show' do
      expect(get: "/ripples/#{uuid}").to route_to('ripples#show', uuid: uuid)
    end

    it 'routes to #create' do
      expect(post: '/ripples').to route_to('ripples#create')
    end

    it 'routes to #destroy' do
      expect(delete: "/ripples/#{uuid}").to route_to('ripples#destroy', uuid: uuid)
    end
  end
end
