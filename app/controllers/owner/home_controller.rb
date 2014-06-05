module Owner
  class HomeController < ::OwnerController

    def index
      authorize! :show, :owner_home
    end
  end
end
