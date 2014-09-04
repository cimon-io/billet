module Authentification
  class ConfirmationController < ::AuthentificationController
    helper_method :resource

    def create
      @user = Clearance.configuration.user_model.find_by confirmation_token: params[:confirmation]
      @user.confirm!
      sign_in(@user) do |status|
        if status.success?
          redirect_to url_after_confirmation
        else
          flash.now.notice = status.failure_message
          render template: 'sessions/new', status: :unauthorized
        end
      end
    end

    protected

    def resource
      @user
    end

  end
end
