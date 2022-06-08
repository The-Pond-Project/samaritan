# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Impact features' do
  # rubocop:disable Layout/LineLength
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
      expect(page).to have_content('See the affect of KindCards and a detailed breakdown on Ripples of Kindness.')
      expect(page).to have_content('Active KindCards')
      expect(page).to have_content('Total KindCards')
      expect(page).to have_content('Ripples of Kindness')
      expect(page).to have_content('Recorded in the last 30 days')
      expect(page).to have_content('Releases')
      expect(page).to have_content('Average KindCard amount per release')
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
      expect(page).to have_content('Detailed look at Ripples and Ponds (KindCards)')
      expect(page).to have_content('Largest Pond (KindCard) size')
      expect(page).to have_content('International Ripples')
      expect(page).to have_content('Domestic Ripples')
      expect(page).to have_content('The last Ripple Location')
    end
  end
  # rubocop:enable Layout/LineLength
end
