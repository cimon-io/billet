module Client
  class ApplicationController < ::ApplicationController
    prepend_view_path 'app/views/client'
    check_authorization
    respond_to :html

    include ::Menuseful::Item
    include ::PageTitle

    helper_method :title_prefix, :current_company

    before_filter :authorize_company!

    susanin(
      root: ->(r) { [:client, r] }
    )

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to destroy_user_session_url, :alert => exception.message
    end

    protected

    def title_prefix
      current_company.name
    end

    def current_company
      @current_company ||= current_user.company
    end

    def current_ability
      @current_ability ||= Ability.new(current_user, current_company)
    end

    def authorize_company!
      authorize! :login, current_company
    end

  end
end
