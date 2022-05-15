# frozen_string_literal: true

RSpec.shared_examples 'navbar' do
  # rubocop:disable RSpec/MultipleExpectations
  describe 'navbar' do
    it 'displays links' do
      expect(page).to have_link('Home', href: '/')
      expect(page).to have_link('Impact', href: '/impact')
      expect(page).to have_link('Ponds', href: '/ponds')
      expect(page).to have_link('Partners', href: '/organizations')
      expect(page).to have_link('Donate', href: '/donate')
      expect(page).to have_link('Partner with us', href: '/')
      expect(page).to have_link('Contribute', href: '/contribute')
      expect(page).to have_link('Tags', href: '/tags')
      expect(page).to have_link('Login', href: '/users/sign_in')
    end

    it 'can navigate to home' do
      click_link('Home')
      expect(page).to have_current_path('/')
    end

    it 'can navigate to impact' do
      click_link('Impact')
      expect(page).to have_current_path('/impact')
    end

    it 'can navigate to ponds' do
      click_link('Ponds', match: :first)
      expect(page).to have_current_path('/ponds')
    end

    it 'can navigate to partners' do
      click_link('Partners')
      expect(page).to have_current_path('/organizations')
    end

    it 'can navigate to donate' do
      click_link('Donate', match: :first)
      expect(page).to have_current_path('/donate')
    end

    it 'can navigate to partner with us' do
      click_link('Partner with us')
      expect(page).to have_current_path('/')
    end

    it 'can navigate to contribute' do
      click_link('Contribute', match: :first)
      expect(page).to have_current_path('/contribute')
    end

    it 'can navigate to tags' do
      click_link('Tags', match: :first)
      expect(page).to have_current_path('/tags')
    end

    it 'can navigate to login' do
      click_link('Login')
      expect(page).to have_current_path('/users/sign_in')
    end
  end
  # rubocop:enable RSpec/MultipleExpectations
end
