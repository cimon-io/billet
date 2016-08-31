Rails.application.config.action_mailer.default_url_options = { :host => (ENV['SMTP_1_DOMAIN'] || ENV['CIMON_DOMAIN_0'] ||  'lvh.me:3000') }
Rails.application.config.action_mailer.smtp_settings = {
  address: ENV.fetch('SMTP_1_ADDRESS', 'localhost'),
  port: ENV.fetch('SMTP_1_PORT', 25).to_i,
  domain: (ENV['SMTP_1_DOMAIN'] || ENV['CIMON_DOMAIN_0'] ||  'lvh.me:3000'),
  authentication: ENV.fetch('SMTP_1_AUTHENTICATION', nil),
  enable_starttls_auto: ENV.fetch('SMTP_1_ENABLE_STARTTLS_AUTO', 'false') == 'true',
  user_name: ENV.fetch('SMTP_1_USER_NAME', nil),
  password: ENV.fetch('SMTP_1_PASSWORD', nil),
  openssl_verify_mode: ENV.fetch('SMTP_1_OPENSSL_VERIFY_MODE', nil),
}
