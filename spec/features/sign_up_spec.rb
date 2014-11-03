require 'rails_helper'


describe 'Registration process' do
  let(:public_home_page) { PublicHomePage.new }
  let(:sign_up_page) { SignUpPage.new }

  let(:company) { Company.first }
  let(:user) { User.first }

  context "sucessful registration" do
    before do
      sign_up_page.load
      expect(sign_up_page).to be_displayed
      sign_up_page.company_name.set 'company name'
      sign_up_page.user_email.set 'user@qwe.qwe'
      sign_up_page.user_password.set 'password'
      sign_up_page.user_password_confirmaiton.set 'password'
      sign_up_page.submit.click
    end

    it 'creates user and company' do
      expect(public_home_page).to be_displayed
      expect(company.name).to eq('company name')
      expect(user.email).to eq('user@qwe.qwe')
    end

  end

end
