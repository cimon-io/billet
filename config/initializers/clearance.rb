class BackDoor
  def initialize(app)
    @app = app
  end

  def call(env)
    if sign_in_through_the_back_door(env)
      [301, {"Location" => env['REQUEST_PATH']}, []]
    else
      @app.call(env)
    end
  end

  private

  def sign_in_through_the_back_door(env)
    params = Rack::Utils.parse_query(env['QUERY_STRING'])
    user_token = params['back_door_token']

    if user_token.present?
      user = Clearance.configuration.user_model.find_by(remember_token: user_token)
      env[:clearance].sign_in(user)
      user_token
    end
  end
end

Clearance.configure do |config|
  config.mailer_sender = ENV.fetch('SMTP_1_REPLY_ADDRESS', 'reply@lvh.me')
  config.httponly = ENV.fetch('APP_COOKIE_HTTP_ONLY', 'false') == 'true' ? true : false
  config.cookie_domain = ENV.fetch('APP_1_DOMAIN', '.lvh.me')
  config.cookie_expiration = lambda { |cookies| 1.year.from_now.utc }
  config.routes = false
  config.sign_in_guards = [EmailConfirmationGuard]

  # config.cookie_path = '/'
  # config.password_strategy = Clearance::PasswordStrategies::BCrypt
  # config.redirect_url = '/'
  # config.secure_cookie = false
  # config.user_model = User
end
