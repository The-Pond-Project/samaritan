# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pond features' do
  let(:organization) { create(:organization) }
  let(:release) { create(:release, organization: organization) }
  let(:tags) { create_list(:tag, 3, organization: organization) }
  let(:ponds) { create_list(:pond, 5, release: release) }
  let(:ripples) { create_list(:ripple, 5, pond: ponds.first, tags: tags) }

  before do
    ripples
    visit('/ponds')
  end

  # include_examples 'navbar'
  # include_examples 'footer'

  describe 'table' do
    it 'displays content' do
      expect(page).to have_content('Pond Key')
      expect(page).to have_content('Created')
      expect(page).to have_content('Ripples')
      expect(page).to have_content('Last active')
    end
  end
end
