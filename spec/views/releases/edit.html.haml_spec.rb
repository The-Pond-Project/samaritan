# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'releases/edit', type: :view do
  before do
    @release = assign(:release, Release.create!(
                                  name: 'MyString',
                                  description: 'MyText',
                                  references: ''
                                ))
  end

  it 'renders the edit release form' do
    render

    assert_select 'form[action=?][method=?]', release_path(@release), 'post' do
      assert_select 'input[name=?]', 'release[name]'

      assert_select 'textarea[name=?]', 'release[description]'

      assert_select 'input[name=?]', 'release[references]'
    end
  end
end
