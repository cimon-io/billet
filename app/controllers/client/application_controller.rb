module Client
  class ApplicationController < ::ApplicationController
    prepend_view_path "app/views/client"
    respond_to :html

    include ::MenuItem
    include ::PageTitle

    helper_method :title_prefix, :current_company

    protected

    def title_prefix
      current_company.name
    end

    def current_company
      @current_company ||= current_user.company
    end

  end
end
