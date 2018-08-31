module Providers
  class DeveloperProviderPage < SitePrism::Page
    set_url '/auth/developer'
    set_url_matcher %r{\/auth\/developer}

    element :name, 'input#name'
    element :email, 'input#email'
    element :submit, 'button[type=submit]'
  end
end
