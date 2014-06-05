module Public
  class HomeController < ::PublicController
    page_title "Welcome"

    def index
      authorize! :show, :public_home
    end
  end
end
