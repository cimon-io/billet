module Client
  class HomeController < ::ClientController
    def index
      authorize! :show, :client_home
    end
  end
end
