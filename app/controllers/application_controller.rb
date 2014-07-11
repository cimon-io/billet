class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ::Clearance::Controller
  include ::Susanin

  # polymorphic_url_prefix do
  #   {
  #     User => ->(resource) { [resource.company, resource] }
  #   }
  # end

end
