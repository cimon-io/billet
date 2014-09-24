module Authentification
  class RegistrationController < ::AuthentificationController
    before_filter :avoid_sign_in, only: [:create, :new], if: :signed_in?

    def new
      @company = Company.new(users: [User.new])
    end

    def create
      @company = company_from_params

      if @company.save
        sign_in(@company.users.first) do |status|
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

    def company_from_params
      Company.new(permitted_params)
    end

    def permitted_params
      params.require(:company).permit(:name, :subdomain, :users_attributes => [:email, :password, :password_confirmation])
    end

    def title_prefix
      'Registration'
    end

    def resource
      company_from_params
    end

  end
end
