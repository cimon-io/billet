module MockAuthorization
  extend ActiveSupport::Concern

  included do
    helper_method :can?
    hide_action :can?
  end

  protected

  def current_ability
    raise "What are you doing"
  end

  def can?
    true
  end

end
