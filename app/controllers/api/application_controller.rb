module Api
  class ApplicationController < ::ApplicationController
    prepend_view_path 'app/views/api'
    respond_to :json
  end
end
