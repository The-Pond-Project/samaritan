# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'organizations/index', type: :view do
  before do
    assign(:organizations, [
             Organization.create!(
               name: 'Name',
               description: 'MyText',
               address: 'Address',
               website: 'Website'
             ),
             Organization.create!(
               name: 'Name',
               description: 'MyText',
               address: 'Address',
               website: 'Website'
             ),
           ])
  end

  it 'renders a list of organizations' do
    render
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
    assert_select 'tr>td', text: 'Address'.to_s, count: 2
    assert_select 'tr>td', text: 'Website'.to_s, count: 2
  end
end
