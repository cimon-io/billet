module Owner
  class NewUserPage < SitePrism::Page
    set_url '/companies{/company_id}/users/new'
    set_url_matcher /companies\/.*\/users\/new/

    element :email, '#user_email'
    element :password, '#user_password'
    element :password_confirmation, '#user_password_confirmation'
    element :sign_up, 'input[name=commit]'
  end
end
