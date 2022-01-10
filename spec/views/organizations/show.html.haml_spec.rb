# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'organizations/show', type: :view do
  before do
    @organization = assign(:organization, Organization.create!(
                                            name: 'Name',
                                            description: 'MyText',
                                            address: 'Address',
                                            website: 'Website'
                                          ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/Website/)
  end
end
