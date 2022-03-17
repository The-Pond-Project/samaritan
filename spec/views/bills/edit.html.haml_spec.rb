require 'rails_helper'

RSpec.describe "bills/edit", type: :view do
  before(:each) do
    @bill = assign(:bill, Bill.create!(
      name: "MyString",
      yearly: false,
      monthly: false,
      amount: 1.5,
      paid: false
    ))
  end

  it "renders the edit bill form" do
    render

    assert_select "form[action=?][method=?]", bill_path(@bill), "post" do

      assert_select "input[name=?]", "bill[name]"

      assert_select "input[name=?]", "bill[yearly]"

      assert_select "input[name=?]", "bill[monthly]"

      assert_select "input[name=?]", "bill[amount]"

      assert_select "input[name=?]", "bill[paid]"
    end
  end
end
