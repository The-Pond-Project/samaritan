# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'releases/new', type: :view do
  before do
    assign(:release, Release.new(
                       name: 'MyString',
                       description: 'MyText',
                       references: ''
                     ))
  end

  it 'renders new release form' do
    render

    assert_select 'form[action=?][method=?]', releases_path, 'post' do
      assert_select 'input[name=?]', 'release[name]'

      assert_select 'textarea[name=?]', 'release[description]'

      assert_select 'input[name=?]', 'release[references]'
    end
  end
end
