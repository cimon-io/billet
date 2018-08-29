require 'sidekiq/web'
require_relative './redis.rb'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == Settings.admin.name && password == Settings.admin.password
end

Sidekiq.configure_server do |config|
  config.redis = { url: $redis_url }

  database_url = ENV['DATABASE_URL']
  if database_url
    ENV['DATABASE_URL'] = "#{database_url}?pool=25"
    ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: $redis_url }
end
