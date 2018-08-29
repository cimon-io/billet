class PublicHomePage < SitePrism::Page
  set_url '/'
  set_url_matcher %r{\/}

  element :client_link, 'a', text: 'Dashboard'
  element :sign_in_link, 'a', text: 'Sign in'
  element :sign_out_link, 'a', text: 'Sign out'
end
