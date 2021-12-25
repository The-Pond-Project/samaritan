# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pebbles/new', type: :view do
  before do
    assign(:pebble, Pebble.new(
                      uuid: 'MyString',
                      postal_code: 'MyString',
                      city: 'MyString',
                      region: 'MyString',
                      country: 'MyString',
                      key: 'MyString'
                    ))
  end

  it 'renders new pebble form' do
    render

    assert_select 'form[action=?][method=?]', pebbles_path, 'post' do
      assert_select 'input[name=?]', 'pebble[uuid]'

      assert_select 'input[name=?]', 'pebble[postal_code]'

      assert_select 'input[name=?]', 'pebble[city]'

      assert_select 'input[name=?]', 'pebble[region]'

      assert_select 'input[name=?]', 'pebble[country]'

      assert_select 'input[name=?]', 'pebble[pebble_key]'
    end
  end
end
