# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'releases/index', type: :view do
  before do
    assign(:releases, [
             Release.create!(
               name: 'Name',
               description: 'MyText',
               references: ''
             ),
             Release.create!(
               name: 'Name',
               description: 'MyText',
               references: ''
             ),
           ])
  end

  it 'renders a list of releases' do
    render
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
    assert_select 'tr>td', text: ''.to_s, count: 2
  end
end
