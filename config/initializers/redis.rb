if ENV["REDIS_URL"]
  $redis_url = ENV["REDIS_URL"]
else
  host = ENV.fetch('REDIS_1_PORT_6379_TCP_HOST', 'localhost')
  port = ENV.fetch('REDIS_1_PORT_6379_TCP_PORT', '6379')
  $redis_url = "redis://#{host}:#{port}"
end

$redis = Redis.new(url: $redis_url)
