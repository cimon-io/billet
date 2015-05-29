class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ::Clearance::Controller
  include ::Veil::Controller
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

  def current_config
    @current_config ||= ::Settings.default_user_config
  end

end
