module MockAuthorization
  extend ActiveSupport::Concern

  included do
    helper_method :can?, :signed_in?
  end

  protected

  def current_ability
    raise "What are you doing"
  end

  def can?
    true
  end

  def signed_in?
    true
  end

end
