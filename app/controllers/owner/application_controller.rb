module Owner

  class ApplicationController < ::ApplicationController
    prepend_view_path "app/views/owner"
    respond_to :html

    include ::MenuItem
    include ::PageTitle

    helper_method :title_prefix

    http_basic_authenticate_with name: Settings.admin.name, password: Settings.admin.password

    protected

    def title_prefix
      "Admin panel"
    end

  end

end

