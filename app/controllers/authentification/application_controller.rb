module Authentification
  class ApplicationController < ::ApplicationController
    prepend_view_path 'app/views/authentification'
    respond_to :html

    include ::Menuseful::Item
    include ::PageTitle

    helper_method :title_prefix

    susanin do
      {
        :root => ->(r) { [(signed_in? ? :client : :public), r] }
      }
    end

    protected

    def title_prefix
      'Authentification'
    end

    def url_after_create
      Clearance.configuration.redirect_url
    end

    def url_after_destroy
      root_url
    end

    def url_after_confirmation
      root_url
    end

    def title_prefix
      'Authentification and Registration'
    end


  end
end
