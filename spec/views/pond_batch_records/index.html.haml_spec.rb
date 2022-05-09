# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'pond_batch_records/index', type: :view do
  before do
    assign(:pond_batch_records, [
             PondBatchRecord.create!(
               organization: '',
               amount: 2,
               key: 'Key'
             ),
             PondBatchRecord.create!(
               organization: '',
               amount: 2,
               key: 'Key'
             ),
           ])
  end

  it 'renders a list of pond_batch_records' do
    render
    assert_select 'tr>td', text: ''.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
    assert_select 'tr>td', text: 'Key'.to_s, count: 2
  end
end
