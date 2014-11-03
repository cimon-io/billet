class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ::Clearance::Controller
  include ::Susanin
  include ::Menuseful::Item
  include ::PageTitle
  include ::InheritedResourcesExtentions
  include ::StateMachineAbilities
  include ::SentientController

  helper_method :title_prefix

  protected

  def title_prefix
    nil
  end

end
