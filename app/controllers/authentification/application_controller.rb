module Authentification
  class ApplicationController < ::ApplicationController
    prepend_view_path 'app/views/authentification'
    respond_to :html

    helper_method :title_prefix

    susanin do
      {
        # :root => ->(r) { [(signed_in? ? :client : :public), r] }
      }
    end

    protected

    def title_prefix
      'Authentification'
    end

    def title_prefix
      'Authentification and Registration'
    end


  end
end
