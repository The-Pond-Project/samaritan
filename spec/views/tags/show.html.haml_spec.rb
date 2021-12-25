# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'tags/show', type: :view do
  before do
    @tag = assign(:tag, Tag.create!(
                          name: 'Name',
                          description: 'MyText',
                          organization: 'Organization',
                          approved: false
                        ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Organization/)
    expect(rendered).to match(/false/)
  end
end
