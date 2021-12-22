# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pages/home', type: :view do
  it 'displays all home page content' do
    render
    expect(rendered).to match(/The Pond Project/)
    expect(rendered).to match(/Kindness passed on./)
  end
end
