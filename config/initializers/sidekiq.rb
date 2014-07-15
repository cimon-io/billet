require 'sidekiq/web'

if ENV["REDIS_URL"]
  $redis_url = ENV["REDIS_URL"]
else
  host = ENV.fetch('REDIS_1_PORT_6379_TCP_HOST', 'localhost')
  port = ENV.fetch('REDIS_1_PORT_6379_TCP_PORT', '6379')
  $redis_url = "redis://#{host}:#{port}"
end

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == Settings.admin.name && password == Settings.admin.password
end

Sidekiq.configure_server do |config|
  config.redis = { :url => $redis_url }
end

Sidekiq.configure_client do |config|
  config.redis = { :url => $redis_url }
end
