class ApplicationController < ActionController::Base
  respond_to :html
  protect_from_forgery with: :exception
  include ::Clearance::Controller
  include ::Susanin
  include ::Menuseful::Item
  include ::PageTitle

  helper_method :title_prefix

  protected

  def title_prefix
    nil
  end

end
