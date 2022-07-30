# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home features' do
  # rubocop:disable Layout/LineLength
  let(:organization) { create(:organization) }
  let(:release) { create(:release, organization: organization) }
  let(:tags) { create_list(:tag, 3, organization: organization) }
  let(:ponds) { create_list(:pond, 5, release: release) }
  let(:ripples) { create_list(:ripple, 5, pond: ponds.first, tags: tags) }

  before do
    ripples
    visit('/')
  end

  include_examples 'navbar'
  include_examples 'footer'

  describe 'welcometron' do
    it 'displays content' do
      expect(page).to have_content('Kindness Passed On')
      expect(page).to have_content('Do a generous act for someone and track the impact that your kindness makes on the world.')
      expect(page).to have_link('Learn More', href: '#about')
    end
  end

  describe 'qoute' do
    it 'displays content' do
      expect(page).to have_content('No act of kindness, no matter how small, is ever wasted.')
    end
  end

  describe 'how it works' do
    it 'displays content' do
      expect(page).to have_content('How it works')
      expect(page).to have_content('A KindCard is a physical paper card. The QR code on the KindCard is scanned to add a ripple of kindness to the pond.')
      expect(page).to have_content('Do It!')
      expect(page).to have_content('Start a ripple effect of kindness by doing a thoughtful and selfless act for someone.')
      expect(page).to have_content('Record It!')
      expect(page).to have_content('Record your act of kindness by scanning your KindCard and creating a ripple. Get notified as your good deed inspires others to act!')
      expect(page).to have_content('Pass It!')
      expect(page).to have_content('Let the kindness continue. Leave the KindCard with the recipient of your kind act.')
    end
  end

  describe 'about' do
    it 'displays content' do
      expect(page).to have_content('ABOUT')
      expect(page).to have_content('The Pond Project is an open source project that is focused on making a difference in the community through selfless acts of kindness.')
      expect(page).to have_content('Our goal is to show the impact of "Kindness Passed On". The impact that an act of kindness can have on you (the giver), on the recipient, and the unfathomable effect it has on the world around us. The Pond Project is not a non-profit rather we partner with a not-for-profit organization every year and give 100% of KindCard proceeds for that year to the organization. So every time you pass on a kindcard you are not only impacting the recipient, you are also blessing a non-profit and their mission.')
      expect(page).to have_content("Anyone and everyone can participate in this project. Businesses can partner with us by buying KindCards and distributing them to their employees, Non-profits can participate by coming alongside of us and promoting love in kindness in our communities, developers can participate by contributing their time and ideas to build the platform, individuals can participate by doing a selfless act and then passing on their KindCard. If you don't have a KindCard you can participate by practicing empathy, kindness, selfless, and generosity.")
    end
  end
  # rubocop:enable Layout/LineLength
end
