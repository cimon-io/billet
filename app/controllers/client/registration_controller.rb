module Client
  class RegistrationController < ::ClientController
    before_filter :avoid_sign_in, only: [:create, :new], if: :signed_in?
    layout 'sessions'

    def new
      @company = Company.new(users: [User.new])
    end

    def create
      @company = company_from_params

      if @company.save
        redirect_back_or url_after_create
      else
        render action: 'new'
      end
    end

    private

    def avoid_sign_in
      redirect_to Clearance.configuration.redirect_url
    end

    def url_after_create
      Clearance.configuration.redirect_url
    end

    def company_from_params
      Company.new(permitted_params)
    end

    def permitted_params
      params.require(:company).permit(:name, :users_attributes => [:email, :password, :password_confirmation])
    end

    def title_prefix
      'Registration'
    end
  end
end
