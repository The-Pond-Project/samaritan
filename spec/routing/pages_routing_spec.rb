# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :routing do
  describe 'routing' do
    it 'routes to #impact' do
      expect(get: '/impact').to route_to('pages#impact')
    end

    it 'routes to #donate' do
      expect(get: '/donate').to route_to('pages#donate')
    end

    it 'routes to #contribute' do
      expect(get: '/contribute').to route_to('pages#contribute')
    end

    it 'routes to #ripples' do
      expect(get: '/ripples').to route_to('pages#ripples')
    end
  end
end
