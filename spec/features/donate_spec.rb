# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Donate features' do
  # rubocop:disable Layout/LineLength
  let(:bill) do
    create(:bill, document: Rack::Test::UploadedFile.new('spec/fixtures/kindnesspassedon.pdf', 'pdf'))
  end

  before do
    bill
    visit('/donate')
  end

  include_examples 'navbar'
  include_examples 'footer'

  describe 'welcometron' do
    it 'displays content' do
      expect(page).to have_content('Donate. Participate through giving')
      expect(page).to have_link('Donate to MissionForKindness', href: '#donate')
    end
  end

  describe 'donate form' do
    it 'displays content' do
      expect(page).to have_content('Any amount is appreciated and will help us continue our mission.')
    end
  end

  describe 'about donations' do
    it 'displays content' do
      expect(page).to have_content('We are transparent about all donations and the use of those donations. All money given using this page will go to MissionForKindness and the costs of running/maintaing the platform. These funds will not go to any of our partnered charities, to find out more on how to give to a partnedred charity go here.')
      expect(page).to have_content('Below you will find a list of all of our costs and reciepts. This is our transparent and collaborative way to show what exactly your donation does to help our mission.')
    end
  end

  describe 'costs and receipts' do
    it 'displays content' do
      expect(page).to have_content(Time.current.year)
      expect(page).to have_content("#{bill.name} |")
      expect(page).to have_content(bill.cost)
      expect(page).to have_link("Donate #{bill.cost}", href: donations_path(amount: bill.amount))
      expect(page).to have_link('View Bill')
    end
  end
  # rubocop:enable Layout/LineLength
end
