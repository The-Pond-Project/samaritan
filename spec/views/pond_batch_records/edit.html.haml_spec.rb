# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pond_batch_records/edit', type: :view do
  before do
    @pond_batch_record = assign(:pond_batch_record, PondBatchRecord.create!(
                                                      organization: '',
                                                      amount: 1,
                                                      key: 'MyString'
                                                    ))
  end

  it 'renders the edit pond_batch_record form' do
    render

    assert_select 'form[action=?][method=?]', pond_batch_record_path(@pond_batch_record), 'post' do
      assert_select 'input[name=?]', 'pond_batch_record[organization]'

      assert_select 'input[name=?]', 'pond_batch_record[amount]'

      assert_select 'input[name=?]', 'pond_batch_record[key]'
    end
  end
end
