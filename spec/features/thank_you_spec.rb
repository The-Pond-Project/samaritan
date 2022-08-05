# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Thank You9 features' do
  # rubocop:disable Layout/LineLength

  before do
    Flipper.enable(:accepting_partners
    visit('/thank-you')
  end

  include_examples 'navbar'
  include_examples 'footer'

  describe 'message' do
    it 'displays content' do
      expect(page).to have_content('Openhanded hearts like yours, are not so easy to find. It takes a special person to be so generous and kind.')
      expect(page).to have_content('To care so much for your fellow human is a quality all too rare. Yet you give of your resources and time, for all in need to share.')
      expect(page).to have_content("So thank you for being a Altruist, we're privileged to accept your donation. We want you to know how appreciated you are, not just today, but forever.")
    end
  end
  # rubocop:enable Layout/LineLength
end
