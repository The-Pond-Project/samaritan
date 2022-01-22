# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'releases/show', type: :view do
  before do
    @release = assign(:release, Release.create!(
                                  name: 'Name',
                                  description: 'MyText',
                                  references: ''
                                ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
