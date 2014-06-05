module Public

  class ApplicationController < ::ApplicationController
    prepend_view_path "app/views/public"
    respond_to :html

    include ::PageTitle

  end

end

