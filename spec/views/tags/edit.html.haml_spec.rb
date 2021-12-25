# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'tags/edit', type: :view do
  before do
    @tag = assign(:tag, Tag.create!(
                          name: 'MyString',
                          description: 'MyText',
                          organization: 'MyString',
                          approved: false
                        ))
  end

  it 'renders the edit tag form' do
    render

    assert_select 'form[action=?][method=?]', tag_path(@tag), 'post' do
      assert_select 'input[name=?]', 'tag[name]'

      assert_select 'textarea[name=?]', 'tag[description]'

      assert_select 'input[name=?]', 'tag[organization]'

      assert_select 'input[name=?]', 'tag[approved]'
    end
  end
end
