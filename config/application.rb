require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Billet
  class Application < Rails::Application
    require 'authenticator'
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths += %W[#{config.root}/lib #{config.root}/vendor/controller_concerns #{config.root}/vendor/helpers]

    config.active_job.queue_adapter = :sidekiq

    config.middleware.use ::Authenticator::Backdoor
    config.middleware.use ::Authenticator::Middleware

    config.active_record.schema_format = :sql
  end
end
