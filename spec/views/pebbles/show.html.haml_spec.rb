# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pebbles/show', type: :view do
  before do
    @pebble = assign(:pebble, Pebble.create!(
                                uuid: 'Uuid',
                                postal_code: 'Postal Code',
                                city: 'City',
                                region: 'Region',
                                country: 'Country',
                                pebble_key: 'Pebble Key'
                              ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Uuid/)
    expect(rendered).to match(/Postal Code/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/Region/)
    expect(rendered).to match(/Country/)
    expect(rendered).to match(/Pebble Key/)
  end
end
