require "spec_helper"


describe 'Registration process' do
  let!(:user) { create :user, email: 'user@qwe.qwe' }
  let(:public_home_page) { PublicHomePage.new }
  let(:sign_in_page) { SignInPage.new }

  context 'sign out' do
    before do
      sign_in user
      public_home_page.load
    end

    it 'sign out perfectly' do
      expect(public_home_page).to be_displayed
      expect(public_home_page).to have_sign_out_link
      public_home_page.sign_out_link.click
      expect(public_home_page).to be_displayed
    end
  end

  context 'sign in' do
    it 'signs in perfectly' do
      public_home_page.load
      public_home_page.sign_in_link.click
      expect(sign_in_page).to be_displayed
      sign_in_page.email.set 'user@qwe.qwe'
      sign_in_page.password.set 'password'
      sign_in_page.submit.click
    end
  end
end
