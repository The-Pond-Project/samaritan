# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'organizations/edit', type: :view do
  before do
    @organization = assign(:organization, Organization.create!(
                                            name: 'MyString',
                                            description: 'MyText',
                                            address: 'MyString',
                                            website: 'MyString'
                                          ))
  end

  it 'renders the edit organization form' do
    render

    assert_select 'form[action=?][method=?]', organization_path(@organization), 'post' do
      assert_select 'input[name=?]', 'organization[name]'

      assert_select 'textarea[name=?]', 'organization[description]'

      assert_select 'input[name=?]', 'organization[address]'

      assert_select 'input[name=?]', 'organization[website]'
    end
  end
end
