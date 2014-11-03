require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Billet
  class Application < Rails::Application

    config.active_record.observers = []
    config.active_record.observers += Dir[Rails.root.join('app', 'observers', '*_observer.rb')].map { |i| File.basename(i, '.rb') }
    config.active_record.observers += Dir[Rails.root.join('app', 'trackers', '*_tracker.rb')].map { |i| File.basename(i, '.rb') }

    config.autoload_paths += %W(#{config.root}/lib)

    config.generators do |g|
      g.template_engine :haml
      g.factory_girl false
    end

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', "**", '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en
    I18n.config.enforce_available_locales = true

    config.middleware.use "::BackDoor"
    config.middleware.use JQuery::FileUpload::Rails::Middleware

    config.assets.precompile += %w(mail.css)

    config.action_mailer.default_url_options = { :host => ENV.fetch('SMTP_1_DOMAIN', 'lvh.me:3000') }
    config.action_mailer.smtp_settings = {
      address: ENV.fetch('SMTP_1_ADDRESS', 'localhost'),
      port: ENV.fetch('SMTP_1_PORT', 25).to_i,
      domain: ENV.fetch('SMTP_1_DOMAIN', 'lvh.me:3000'),
      authentication: ENV.fetch('SMTP_1_AUTHENTICATION', nil),
      enable_starttls_auto: ENV.fetch('SMTP_1_ENABLE_STARTTLS_AUTO', 'false') == 'true',
      user_name: ENV.fetch('SMTP_1_USER_NAME', nil),
      password: ENV.fetch('SMTP_1_PASSWORD', nil),
      openssl_verify_mode: ENV.fetch('SMTP_1_OPENSSL_VERIFY_MODE', nil),
    }
  end
end
