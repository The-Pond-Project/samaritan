# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Impact features' do
  let(:organization) { create(:organization) }
  let(:release) { create(:release, organization: organization) }
  let(:tags) { create_list(:tag, 3, organization: organization) }
  let(:ponds) { create_list(:pond, 5, release: release) }
  let(:ripples) { create_list(:ripple, 5, pond: ponds.first, tags: tags) }

  before do
    ripples
    visit('/impact')
  end

  include_examples 'navbar'
  include_examples 'footer'

  describe 'header' do
    it 'displays content' do
      expect(page).to have_content('Impact Stats')
      expect(page).to have_content('These are the stats since the first release of KindCards in March 2022.')
      expect(page).to have_content('Active Ponds')
      expect(page).to have_content('Total Ponds')
      expect(page).to have_content('Ripples')
      expect(page).to have_content('In the last 30 days')
      expect(page).to have_content('Releases')
      expect(page).to have_content('Average Release Size')
      expect(page).to have_content('Partnered organizations')
      expect(page).to have_content('Recent Partner')
    end
  end

  describe 'leaderboard' do
    it 'displays content' do
      expect(page).to have_content('is the most used tag')
      expect(page).to have_content('The last Ripple of Kindness was')
    end
  end

  describe 'more stats' do
    it 'displays content' do
      expect(page).to have_content('More Stats')
      expect(page).to have_content('Detailed look at ripples and ponds')
      expect(page).to have_content('Largest Pond size')
      expect(page).to have_content('International Ripples')
      expect(page).to have_content('Domestic Ripples')
      expect(page).to have_content('The last Ripple Location')
    end
  end
end
