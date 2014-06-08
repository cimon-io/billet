class SignInPage < SitePrism::Page
  set_url '/sign_in'
  set_url_matcher /\/sign_in/

  element :email, 'input#session_email'
  element :password, 'input#session_password'
  element :submit, 'input[name=commit]'
end
