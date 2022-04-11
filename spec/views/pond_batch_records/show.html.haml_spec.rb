require 'rails_helper'

RSpec.describe "pond_batch_records/show", type: :view do
  before(:each) do
    @pond_batch_record = assign(:pond_batch_record, PondBatchRecord.create!(
      organization: "",
      amount: 2,
      key: "Key"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Key/)
  end
end
