require 'rails_helper'

RSpec.describe "bills/index", type: :view do
  before(:each) do
    assign(:bills, [
      Bill.create!(
        name: "Name",
        yearly: false,
        monthly: false,
        amount: 2.5,
        paid: false
      ),
      Bill.create!(
        name: "Name",
        yearly: false,
        monthly: false,
        amount: 2.5,
        paid: false
      )
    ])
  end

  it "renders a list of bills" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: 2.5.to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
  end
end
