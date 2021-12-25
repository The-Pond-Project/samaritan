# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ripples/edit', type: :view do
  before do
    @ripple = assign(:ripple, Ripple.create!(
                                uuid: 'MyString',
                                postal_code: 'MyString',
                                city: 'MyString',
                                country: 'MyString',
                                region: 'MyString',
                                user: nil,
                                pebble: nil
                              ))
  end

  it 'renders the edit ripple form' do
    render

    assert_select 'form[action=?][method=?]', ripple_path(@ripple), 'post' do
      assert_select 'input[name=?]', 'ripple[uuid]'

      assert_select 'input[name=?]', 'ripple[postal_code]'

      assert_select 'input[name=?]', 'ripple[city]'

      assert_select 'input[name=?]', 'ripple[country]'

      assert_select 'input[name=?]', 'ripple[region]'

      assert_select 'input[name=?]', 'ripple[user_id]'

      assert_select 'input[name=?]', 'ripple[pebble_id]'
    end
  end
end
