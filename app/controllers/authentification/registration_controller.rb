module Authentification
  class RegistrationController < ::AuthentificationController
    before_filter :avoid_sign_in, only: [:create, :new], if: :signed_in?

    def new
      @user = User.new
    end

    def create
      @user = user_from_params

      if @user.save
        sign_in(@user) do |status|
          if status.success?
            redirect_back_or url_after_create
          else
            flash.now.notice = status.failure_message
            render template: 'sessions/new', status: :unauthorized
          end
        end
      else
        render action: 'new'
      end
    end

    private

    def avoid_sign_in
      redirect_to url_after_create
    end

    def user_from_params
      User.new(permitted_params)
    end

    def permitted_params
      params.require(:user).permit(:email, :password, :password_confirmation, :is_owner)
    end

    def title_prefix
      'Registration'
    end

  end
end
