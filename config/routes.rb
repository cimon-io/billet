Rails.application.routes.draw do
  Dir[Rails.root.join("config/routes/**/*.rb")].each { |f| instance_eval(File.read(f)) }

  scope module: :authentification do
    concerns :authentification_routes
  end

  scope module: :public, as: :public do
    concerns :public_routes
  end

  root to: "public/home#index", via: :get

  mount Sidekiq::Web => '/sidekiq'

end
