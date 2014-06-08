require 'sidekiq/web'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == Settings.admin.name && password == Settings.admin.password
end
