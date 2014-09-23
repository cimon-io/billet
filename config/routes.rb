Rails.application.routes.draw do
  Dir[Rails.root.join("config/routes/**/*.rb")].each { |f| instance_eval(File.read(f)) }

  scope module: :authentification do
    concerns :authentification_routes
  end

  constraints Clearance::Constraints::SignedOut.new do
    root to: "public/home#index", as: :signed_out
  end

  constraints Constraints::Subdomain.api do
    constraints Constraints::ApiAuthentificate.new do
      scope module: :api, as: :api do
        scope '/v1', module: :v1 do
          concerns :api_v1_routes
        end
      end
    end
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
    mount Sidekiq::Web => '/sidekiq'
  end

  root to: "public/home#index", via: :get

end
