RSpec.shared_examples 'navbar' do
  describe 'navbar' do
    it 'displays links' do 
      expect(page).to have_link('Home', href:'/')
      expect(page).to have_link('Impact', href:'/impact')
      expect(page).to have_link('Ponds', href:'/ponds')
      expect(page).to have_link('Partners', href:'/organizations')
      expect(page).to have_link('Donate', href:'/donate')
      expect(page).to have_link('Partner with us', href:'/')
      expect(page).to have_link('Contribute', href:'/contribute')
      expect(page).to have_link('Tags', href:'/')
      expect(page).to have_link('Login', href:'/users/sign_in')
    end

    it 'can navigate to home' do 
      click_link('Home')
      expect(current_path).to eq('/')
    end

    it 'can navigate to impact' do 
      click_link('Impact')
      expect(current_path).to eq('/impact')
    end

    it 'can navigate to ponds' do 
      click_link('Ponds', match: :first)
      expect(current_path).to eq('/ponds')
    end

    it 'can navigate to partners' do 
      click_link('Partners')
      expect(current_path).to eq('/organizations')
    end

    it 'can navigate to donate' do 
      click_link('Donate', match: :first)
      expect(current_path).to eq('/donate')
    end

    it 'can navigate to partner with us' do 
      click_link('Partner with us')
      expect(current_path).to eq('/')
    end

    it 'can navigate to contribute' do 
      click_link('Contribute', match: :first)
      expect(current_path).to eq('/contribute')
    end

    it 'can navigate to tags' do 
      click_link('Tags', match: :first)
      expect(current_path).to eq('/')
    end

    it 'can navigate to login' do 
      click_link('Login')
      expect(current_path).to eq('/users/sign_in')
    end
  end
end