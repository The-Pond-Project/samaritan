# frozen_string_literal: true

RSpec.shared_examples 'footer' do
  # rubocop:disable RSpec/ExampleLength
  # rubocop:disable RSpec/MultipleExpectations
  describe 'footer' do
    # before do
    #   @footer = page.find('#footer')
    # end

    it 'displays content' do
      expect(page).to have_content('Impact')
      expect(page).to have_link('Organizations', href: '/organizations')
      expect(page).to have_link('Tags', href: '/tags')
      expect(page).to have_link('Ponds', href: '/ponds')
      expect(page).to have_link('Ripples', href: '/ripples')
      expect(page).to have_content('Get Involved')
      expect(page).to have_link('Donate', href: '/donate')
      expect(page).to have_link('Contribute', href: 'https://github.com/The-Pond-Project/samaritan')
      expect(page).to have_link('Partner', href: '#')
      expect(page).to have_content('Connect')
      expect(page).to have_link('Story of Kindness', href: '/stories/new')
      expect(page).to have_link('Email', href: 'mailto:kindnesspassedon@gmail.com')
      expect(page).to have_link('Report a bug', href: '#')
    end

    it 'can navigate to organizations' do
      click_link('Organizations')
      expect(page).to have_current_path('/organizations')
    end

    # it 'can navigate to tags' do
    #   click_link('Tags', match: :first)
    #   expect(@footer).to eq('/tags')
    # end

    it 'can navigate to ponds' do
      click_link('Ponds', match: :first)
      expect(page).to have_current_path('/ponds')
    end

    # it 'can navigate to ripples' do
    #   click_link('Ripples')
    #   expect(current_path).to eq('/ripples')
    # end

    it 'can navigate to donate' do
      click_link('Donate', match: :first)
      expect(page).to have_current_path('/donate')
    end

    # it 'can navigate to Contribute' do
    #   click_link('Contribute', match: :first)
    #   expect(@footer).to eq('/https://github.com/The-Pond-Project/samaritan')
    # end

    it 'can navigate to Story of Kindness' do
      click_link('Story of Kindness', match: :first)
      expect(page).to have_current_path('/stories/new')
    end
  end
  # rubocop:enable RSpec/ExampleLength
  # rubocop:enable RSpec/MultipleExpectations
end
