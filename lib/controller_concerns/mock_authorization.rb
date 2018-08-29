module MockAuthorization
  extend ActiveSupport::Concern

  included do
    helper_method :can?, :signed_in?, :current_config
  end

  protected

  def current_ability
    raise "What are you doing"
  end

  def can?(*args)
    true
  end

  def signed_in?
    true
  end

  def current_config
    @current_config ||= ::Settings.default_user_config
  end
end
