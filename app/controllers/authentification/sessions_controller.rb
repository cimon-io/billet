module Authentification
  class SessionsController < ::AuthentificationController
    helper_method :resource

    def new
    end

    def create
      @user = authenticate(params)

      sign_in(@user) do |status|
        if status.success?
          redirect_back_or url_after_create
        else
          flash.now.notice = status.failure_message
          render 'new', status: :unauthorized
        end
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

    def resource
      @user
    end

  end
end
