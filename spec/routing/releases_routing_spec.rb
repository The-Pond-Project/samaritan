# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReleasesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/organizations/kindnesspassedon/releases').to route_to('releases#index',
                                                                          organization_name: 'kindnesspassedon')
    end

    it 'routes to #show' do
      expect(get: '/organizations/kindnesspassedon/releases/1').to route_to('releases#show',
                                                                            id: '1', organization_name: 'kindnesspassedon')
    end
  end
end
