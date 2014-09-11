module Owner
  class UsersController < ::OwnerController
    inherit_resources
    menu_item :users
    page_title "Users"
    belongs_to :company, parent_class: Company

    protected

    def collection_url
      parent_url
    end

  end
end
