module Owner
  class UsersController < ::OwnerController
    inherit_resources
    authorize_resource
    defaults route_prefix: nil
    menu_item :users
    page_title "Users"
    belongs_to :company

    protected

    def collection_url
      parent_url
    end

  end
end
