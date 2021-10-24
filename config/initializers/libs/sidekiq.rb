# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/scheduler'
require 'sidekiq-scheduler/web'
require_relative './redis.rb'

# rubocop:disable Style/ExpandPathArguments, Style/GlobalVars
Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == Settings.admin.name && password == Settings.admin.password
end

Sidekiq.configure_server do |config|
  config.redis = { url: $redis_url, namespace: $redis_namespace }

  if (database_url = ENV['DATABASE_URL'])
    ENV['DATABASE_URL'] = "#{database_url}?pool=50"
    ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
  end

  config.on(:startup) do
    if Settings.application.schedule_jobs
      Sidekiq.schedule = YAML.load_file(File.expand_path("../../../config/schedule.yml", __FILE__))
      Sidekiq::Scheduler.reload_schedule!
    end
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: $redis_url, namespace: $redis_namespace }
end
# rubocop:enable Style/ExpandPathArguments, Style/GlobalVars
