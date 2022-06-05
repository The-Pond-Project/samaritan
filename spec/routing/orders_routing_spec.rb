# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrdersController, type: :routing do
  let(:uuid) { SecureRandom.uuid }

  describe 'routing' do
    it 'routes to #new' do
      expect(get: '/orders/new').to route_to('orders#new')
    end

    it 'routes to #show' do
      expect(get: "/orders/#{uuid}").to route_to('orders#show', uuid: uuid)
    end

    it 'routes to #create' do
      expect(post: '/orders').to route_to('orders#create')
    end
  end
end
