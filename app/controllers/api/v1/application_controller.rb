module Api
  module V1
    class ApplicationController < ::Api::ApplicationController
      prepend_view_path "app/views/api/v1"

    end
  end
end