Clearance.configure do |config|
  config.mailer_sender = ENV.fetch('SMTP_1_REPLY_ADDRESS', 'reply@lvh.me')
  config.httponly = ENV.fetch('APP_COOKIE_HTTP_ONLY', 'false') == 'true' ? true : false
  config.cookie_domain = ENV.fetch('APP_COOKIE_DOMAIN', '.lvh.me')
  config.cookie_expiration = lambda { |cookies| 1.year.from_now.utc }
  config.allow_sign_up = true

  # config.cookie_path = '/'
  # config.password_strategy = Clearance::PasswordStrategies::BCrypt
  # config.redirect_url = '/'
  # config.secure_cookie = false
  # config.sign_in_guards = []
  # config.user_model = User
end
