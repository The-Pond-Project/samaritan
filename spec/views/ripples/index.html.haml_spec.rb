# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ripples/index', type: :view do
  before do
    assign(:ripples, [
             Ripple.create!(
               uuid: 'Uuid',
               postal_code: 'Postal Code',
               city: 'City',
               country: 'Country',
               region: 'Region',
               user: nil,
               pebble: nil
             ),
             Ripple.create!(
               uuid: 'Uuid',
               postal_code: 'Postal Code',
               city: 'City',
               country: 'Country',
               region: 'Region',
               user: nil,
               pebble: nil
             ),
           ])
  end

  it 'renders a list of ripples' do
    render
    assert_select 'tr>td', text: 'Uuid'.to_s, count: 2
    assert_select 'tr>td', text: 'Postal Code'.to_s, count: 2
    assert_select 'tr>td', text: 'City'.to_s, count: 2
    assert_select 'tr>td', text: 'Country'.to_s, count: 2
    assert_select 'tr>td', text: 'Region'.to_s, count: 2
    assert_select 'tr>td', text: nil.to_s, count: 2
    assert_select 'tr>td', text: nil.to_s, count: 2
  end
end
