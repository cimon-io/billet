module Client
  class ProjectsController < ::ClientController
    respond_to :json
    inherit_resources
    authorize_resource
    menu_item :projects
    page_title "Projects"

    protected

    def begin_of_association_chain
      current_company
    end

  end
end
