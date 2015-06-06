module CurrentIdentity
  extend ActiveSupport::Concern

  included do
    helper_method :current_user, :signed_in?, :signed_out?, :url_after_create, :url_after_destroy, :url_after_confirmation
    hide_action(
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
    session[:user_id] = user.id
  end

  def sign_out
    session[:user_id] = nil
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

end
