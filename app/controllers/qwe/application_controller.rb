module Qwe  class ApplicationController < ::ApplicationController
    inlcude MockAuthorization
    prepend_view_path 'app/views/qwe'

    susanin(
      root: ->(r) { [:client, r] }
    )

    helper_method :current_company

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

  end
end
