# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'stories/index', type: :view do
  before do
    assign(:stories, [
             Story.create!(
               title: 'Title',
               body: 'MyText',
               pond_key: 'Pond Key',
               ripple_uuid: 'Ripple Uuid'
             ),
             Story.create!(
               title: 'Title',
               body: 'MyText',
               pond_key: 'Pond Key',
               ripple_uuid: 'Ripple Uuid'
             ),
           ])
  end

  it 'renders a list of stories' do
    render
    assert_select 'tr>td', text: 'Title'.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
    assert_select 'tr>td', text: 'Pond Key'.to_s, count: 2
    assert_select 'tr>td', text: 'Ripple Uuid'.to_s, count: 2
  end
end
