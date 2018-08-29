class ClientHomePage < SitePrism::Page
  set_url '/@'
  set_url_matcher %r{\/@}

  element :sign_in_link, 'a', text: 'Sign in'
  element :sign_out_link, 'a', text: 'Sign out'
end
