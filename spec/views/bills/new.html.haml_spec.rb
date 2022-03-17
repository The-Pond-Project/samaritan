# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'bills/new', type: :view do
  before do
    assign(:bill, Bill.new(
                    name: 'MyString',
                    yearly: false,
                    monthly: false,
                    amount: 1.5,
                    paid: false
                  ))
  end

  it 'renders new bill form' do
    render

    assert_select 'form[action=?][method=?]', bills_path, 'post' do
      assert_select 'input[name=?]', 'bill[name]'

      assert_select 'input[name=?]', 'bill[yearly]'

      assert_select 'input[name=?]', 'bill[monthly]'

      assert_select 'input[name=?]', 'bill[amount]'

      assert_select 'input[name=?]', 'bill[paid]'
    end
  end
end
