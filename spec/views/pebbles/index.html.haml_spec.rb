# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pebbles/index', type: :view do
  before do
    assign(:pebbles, FactoryBot.create_list(:pebble, 2))
  end

  it 'renders a list of pebbles' do
    render
    assert_select 'tr>td', text: 'Uuid'.to_s, count: 2
    assert_select 'tr>td', text: 'Postal Code'.to_s, count: 2
    assert_select 'tr>td', text: 'City'.to_s, count: 2
    assert_select 'tr>td', text: 'Region'.to_s, count: 2
    assert_select 'tr>td', text: 'Country'.to_s, count: 2
    assert_select 'tr>td', text: 'Pebble Key'.to_s, count: 2
  end
end
