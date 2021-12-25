# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'tags/new', type: :view do
  before do
    assign(:tag, Tag.new(
                   name: 'MyString',
                   description: 'MyText',
                   organization: 'MyString',
                   approved: false
                 ))
  end

  it 'renders new tag form' do
    render

    assert_select 'form[action=?][method=?]', tags_path, 'post' do
      assert_select 'input[name=?]', 'tag[name]'

      assert_select 'textarea[name=?]', 'tag[description]'

      assert_select 'input[name=?]', 'tag[organization]'

      assert_select 'input[name=?]', 'tag[approved]'
    end
  end
end
