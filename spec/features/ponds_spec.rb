# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pond features' do
  # rubocop:disable Layout/LineLength
  let(:organization) { create(:organization) }
  let(:release) { create(:release, organization: organization) }
  let(:tags) { create_list(:tag, 3, organization: organization) }
  let(:ponds) { create_list(:pond, 5, release: release) }
  let(:ripples) { create_list(:ripple, 5, pond: ponds.first, tags: tags) }

  before do
    Flipper.enable(:accepting_partners)
    visit('/ponds')
  end

  include_examples 'navbar'
  include_examples 'footer'

  context 'when there are no ponds' do
    before { visit('/ponds') }

    describe 'view' do
      it 'displays content' do
        expect(page).to have_content('nothing to see here....')
        expect(page).to have_content('No ponds have been created yet but, when they are they will show up here.')
      end
    end
  end

  context 'when there are ponds' do
    before do
      ponds
      visit('/ponds')
    end

    describe 'view' do
      it 'displays content' do
        expect(page).to have_content('Ponds')
        expect(page).to have_content('A Pond represents a single act of KindCard. Each time a KindCard is created a new Pond is recorded.')
      end
    end
  end
  # rubocop:enable Layout/LineLength
end
