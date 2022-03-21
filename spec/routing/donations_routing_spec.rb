# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DonationsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/donations').to route_to('donations#create')
    end
  end
end
