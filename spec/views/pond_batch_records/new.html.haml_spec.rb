require 'rails_helper'

RSpec.describe "pond_batch_records/new", type: :view do
  before(:each) do
    assign(:pond_batch_record, PondBatchRecord.new(
      organization: "",
      amount: 1,
      key: "MyString"
    ))
  end

  it "renders new pond_batch_record form" do
    render

    assert_select "form[action=?][method=?]", pond_batch_records_path, "post" do

      assert_select "input[name=?]", "pond_batch_record[organization]"

      assert_select "input[name=?]", "pond_batch_record[amount]"

      assert_select "input[name=?]", "pond_batch_record[key]"
    end
  end
end
