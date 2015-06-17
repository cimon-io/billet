class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ::Veil::Controller
  include ::CurrentIdentity
  include ::Susanin
  include ::Menuseful::Item
  include ::PageTitle
  include ::InheritedResourcesExtentions
  include ::StateMachineAbilities

  helper_method :title_prefix

  protected

  def title_prefix
    nil
  end

end
