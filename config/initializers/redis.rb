# rubocop:disable Style/GlobalVars
if ENV["REDIS_URL"]
  $redis_url = ENV["REDIS_URL"]
else
  host = ENV.fetch('REDIS_1_PORT_6379_TCP_HOST', 'localhost')
  port = ENV.fetch('REDIS_1_PORT_6379_TCP_PORT', '6379')
  $redis_url = "redis://#{host}:#{port}"
end

$redis_namespace = ENV.fetch('REDIS_NAMESPACE', 'default')

$redis = Redis::Namespace.new($redis_namespace, redis: Redis.new(url: $redis_url))
# rubocop:enable Style/GlobalVars
