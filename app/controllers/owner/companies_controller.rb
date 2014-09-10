module Owner
  class CompaniesController < ::OwnerController
    inherit_resources
    menu_item :companies
    page_title "Companies"

    protected

    def permitted_params
      params.permit(company: [:name])
    end

  end
end
