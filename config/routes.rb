Rails.application.routes.draw do
  Dir[Rails.root.join("config/routes/**/*.rb")].each { |f| instance_eval(File.read(f)) }

  scope module: :authentification do
    concerns :authentification_routes
  end

  constraints Clearance::Constraints::SignedOut.new do
    root to: "public/home#index", as: :signed_out
  end

  scope module: :public, as: :public do
    concerns :public_routes
  end

  scope '/@', module: :client, as: :client do
    concerns :client_routes
  end

  scope '/__owner', module: :owner, as: :owner do
    # http_basic_authenticate_with inside controller
    concerns :owner_routes
  end

  mount Sidekiq::Web => '/sidekiq'
  root to: "public/home#index", via: :get

end
