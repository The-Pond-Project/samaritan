require 'rails_helper'

RSpec.describe "bills/show", type: :view do
  before(:each) do
    @bill = assign(:bill, Bill.create!(
      name: "Name",
      yearly: false,
      monthly: false,
      amount: 2.5,
      paid: false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/false/)
  end
end
