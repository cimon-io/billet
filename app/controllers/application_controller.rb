class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ::Clearance::Controller
  include ::Susanin

  # susanin do
  #   {
  #     User => ->(resource) { [resource.company, resource] }
  #   }
  # end

end
