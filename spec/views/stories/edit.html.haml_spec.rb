# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'stories/edit', type: :view do
  before do
    @story = assign(:story, Story.create!(
                              title: 'MyString',
                              body: 'MyText',
                              pond_key: 'MyString',
                              ripple_uuid: 'MyString'
                            ))
  end

  it 'renders the edit story form' do
    render

    assert_select 'form[action=?][method=?]', story_path(@story), 'post' do
      assert_select 'input[name=?]', 'story[title]'

      assert_select 'textarea[name=?]', 'story[body]'

      assert_select 'input[name=?]', 'story[pond_key]'

      assert_select 'input[name=?]', 'story[ripple_uuid]'
    end
  end
end
