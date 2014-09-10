module Public

  class ApplicationController < ::ApplicationController
    respond_to :html

    include ::PageTitle

  end

end
