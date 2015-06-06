class SignInPage < SitePrism::Page
  set_url '/sign_in'
  set_url_matcher /\/sign_in/

  element :developer_provider_link, 'a', text: 'developer'
end
