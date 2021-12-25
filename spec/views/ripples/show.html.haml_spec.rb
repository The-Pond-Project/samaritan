# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ripples/show', type: :view do
  before do
    @ripple = assign(:ripple, Ripple.create!(
                                uuid: 'Uuid',
                                postal_code: 'Postal Code',
                                city: 'City',
                                country: 'Country',
                                region: 'Region',
                                user: nil,
                                pebble: nil
                              ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Uuid/)
    expect(rendered).to match(/Postal Code/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/Country/)
    expect(rendered).to match(/Region/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
