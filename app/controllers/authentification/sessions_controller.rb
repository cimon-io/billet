module Authentification
  class SessionsController < ::AuthentificationController
    helper_method :resource
    before_action :authenticate!, only: :create

    def new
    end

    def create
      if signed_in?
        redirect_back_or url_after_create
      else
        flash.now.notice = "Login failure"
        redirect_back_or url_after_destroy
      end
    end

    def destroy
      sign_out
      redirect_to url_after_destroy
    end

    protected

    def title_prefix
      'Authentification'
    end

    def authenticate!
      sign_in(UserIdentity.find_or_create_with_omniauth(request.env['omniauth.auth']).user)
    end

  end
end
