# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrganizationsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/organizations').to route_to('organizations#index')
    end

    it 'routes to #new' do
      expect(get: '/organizations/new').to route_to('organizations#new')
    end

    it 'routes to #show' do
      expect(get: '/organizations/kindnesspassedon').to route_to('organizations#show',
                                                                 name: 'kindnesspassedon')
    end

    it 'routes to #edit' do
      expect(get: '/organizations/kindnesspassedon/edit').to route_to('organizations#edit',
                                                                      name: 'kindnesspassedon')
    end

    it 'routes to #create' do
      expect(post: '/organizations').to route_to('organizations#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/organizations/kindnesspassedon').to route_to('organizations#update',
                                                                 name: 'kindnesspassedon')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/organizations/kindnesspassedon').to route_to('organizations#update',
                                                                   name: 'kindnesspassedon')
    end

    it 'routes to #destroy' do
      expect(delete: '/organizations/kindnesspassedon').to route_to('organizations#destroy',
                                                                    name: 'kindnesspassedon')
    end
  end
end
