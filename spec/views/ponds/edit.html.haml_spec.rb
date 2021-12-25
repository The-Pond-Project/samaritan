# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pebbles/edit', type: :view do
  before do
    @pebble = assign(:pebble, Pebble.create!(
                                uuid: 'MyString',
                                postal_code: 'MyString',
                                city: 'MyString',
                                region: 'MyString',
                                country: 'MyString',
                                key: 'MyString'
                              ))
  end

  it 'renders the edit pebble form' do
    render

    assert_select 'form[action=?][method=?]', pebble_path(@pebble), 'post' do
      assert_select 'input[name=?]', 'pebble[uuid]'

      assert_select 'input[name=?]', 'pebble[postal_code]'

      assert_select 'input[name=?]', 'pebble[city]'

      assert_select 'input[name=?]', 'pebble[region]'

      assert_select 'input[name=?]', 'pebble[country]'

      assert_select 'input[name=?]', 'pebble[pebble_key]'
    end
  end
end
