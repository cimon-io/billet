class SignUpPage < SitePrism::Page
  set_url '/sign_up'
  set_url_matcher /\/sign_up/

  element :company_name, 'input#company_name'
  element :user_email, 'input#company_users_attributes_0_email'
  element :user_password, 'input#company_users_attributes_0_password'
  element :user_password_confirmaiton, 'input#company_users_attributes_0_password_confirmation'
  element :submit, 'input[name=commit]'
end
