module Authenticator
  class Streak
    attr_reader :env, :session, :cookies, :request

    def initialize(env)
      @env = env
      @request = ::Rack::Request.new(env)
      @session = @request.session
      @cookies = @request.cookies
    end

    def call
      sign_out if session.key?(:sign_out)
      sign_in(UserIdentity.find_or_create_with_omniauth(request.env['omniauth.auth'], current_user)) if request.env['omniauth.auth']
      check_remember_token if remember_token_exists?
      set_session_id if signed_out?

      env['authenticator'] = {
        'signed_out?' => signed_out?,
        'user_active?' => user_active?,
        'signed_in?' => signed_in?,
        'current_user' => current_user
      }
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

    def check_remember_token
      sign_out and return false unless current_user
      sign_out and return false unless find_remembered_user
      sign_out and return false unless current_user == find_remembered_user
      sign_out and return false unless current_user.remember_token == find_remembered_user.remember_token
    end

    def set_session_id
      set_session_id_for(find_remembered_user)
    end

    def sign_in(user_identity)
      return unless user_identity.valid? || user_identity.user
      set_session_id_for(user_identity.user)
      set_remember_token_for(user_identity.user)
    end

    def sign_out
      set_session_id_for(nil)
      set_remember_token_for(nil)
      clean_sign_out_flag
      true
    end

    def remember_token_exists?
      !!cookies[:remember_token]
    end

    def signed_in?
      current_user.present?
    end

    def user_active?
      current_user.try(:active?)
    end

    def signed_out?
      !signed_in?
    end

    private def find_remembered_user
      @find_remembered_user ||= User.where(remember_token: cookies[:remember_token][:value]).first if cookies[:remember_token]
    end


    private def set_session_id_for(user)
      if user.nil?
        session.delete(:user_id)
      else
        session[:user_id] = user.try(:id)
      end
    end

    private def set_remember_token_for(user)
      if user.nil?
        cookies.delete(:remember_token)
      else
        cookies[:remember_token] = { value: user.remember_token, expires: Settings.remember_user_days.days.from_now, httponly: true }
      end
    end

    private def clean_sign_out_flag
      session.delete(:sign_out)
    end
  end

  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      Streak.new(env).call
      @app.call(env)
    end
  end

  class Backdoor
    def initialize(app)
      @app = app
    end

    def call(env)
      request = ::Rack::Request.new(env)

      if request.params['backdoor_token']
        request.session[:user_id] = request.params['user_id'].to_i if request.params['backdoor_token'] == Settings.admin.backdoor && request.params['user_id']
        return [301, {'Location' => request.path, 'Content-Type' => 'text/html'}, ['Moved Permanently']]
      else
        @app.call(env)
      end
    end
  end
end
