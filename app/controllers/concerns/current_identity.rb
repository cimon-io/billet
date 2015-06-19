module CurrentIdentity
  extend ActiveSupport::Concern

  included do
    helper_method :current_config, :current_user, :signed_in?, :signed_out?, :url_after_create, :url_after_destroy, :url_after_confirmation
    hide_action(
      :current_config,
      :current_user,
      :current_user=,
      :sign_in,
      :sign_out,
      :signed_in?,
      :signed_out?,
      :url_after_create,
      :url_after_destroy,
      :url_after_confirmation,
    )

    before_action :set_remember_token, if: :signed_in?
    before_action :set_session_id, if: :signed_out?

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to auth_in_url, :alert => exception.message
    end

  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def current_config
    @current_config ||= (current_user ? current_user.config : ::Settings.default_user_config)
  end

  def current_user
    return nil if session[:user_id].nil?

    if @user.nil? || @user.id != session[:user_id]
      @user = User.find_by!(id: session[:user_id])
    else
      @user
    end
  rescue ActiveRecord::RecordNotFound
    sign_out
    nil
  end

  def current_user=(user)
    sign_in(user)
  end

  def sign_in(user)
    set_session_id_for(user)
    set_remember_token_for(user)
  end

  def sign_out
    set_session_id_for(nil)
    set_remember_token_for(nil)
  end

  def signed_in?
    current_user.present?
  end

  def signed_out?
    !signed_in?
  end

  def url_after_create
    root_url
  end

  def url_after_destroy
    root_url
  end

  def url_after_confirmation
    root_url
  end

  def set_remember_token
    set_remember_token_for(current_user)
  end

  def set_session_id
    set_session_id_for(User.where(remember_token: cookies[:remember_token]).first) if cookies[:remember_token]
  end

  private def set_session_id_for(user)
    session.delete(:user_id) and return if user.nil?
    session[:user_id] = user.id
  end

  private def set_remember_token_for(user)
    cookies.delete(:remember_token) and return if user.nil?
    cookies[:remember_token] = { value: user.remember_token, expires: Settings.remember_user_days.days.from_now, httponly: true }
  end

end
