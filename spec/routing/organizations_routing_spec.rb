# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrganizationsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/organizations').to route_to('organizations#index')
    end

    it 'routes to #show' do
      expect(get: '/organizations/kindnesspassedon').to route_to('organizations#show',
                                                                 name: 'kindnesspassedon')
    end
  end
end
