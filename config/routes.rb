Rails.application.routes.draw do
  Dir[Rails.root.join("config/routes/**/*.rb")].each { |f| instance_eval(File.read(f)) }

  scope module: :authentification do
    get '/sign_in' => 'sessions#new', as: 'sign_in'
    post '/sign_in' => 'sessions#create'
    delete '/sign_out' => 'sessions#destroy', as: 'sign_out'
    get '/sign_up' => 'registration#new', as: 'sign_up'
    post '/sign_up' => 'registration#create'
    get '/confirm' => 'confirmation#create', as: 'confirmation'
  end

  scope module: :public do
    concerns :public_routes
  end

  constraints Clearance::Constraints::SignedIn.new do
    scope '/@', module: :client do
      concerns :client_routes
    end
  end

  constraints Clearance::Constraints::SignedOut.new do
    root to: "public/home#index", as: :signed_out
  end

  constraints Constraints::Subdomain.api do
    constraints Constraints::ApiAuthentificate.new do
      scope module: :api do
        scope '/v1', module: :v1 do
          concerns :api_v1_routes
        end
      end
    end
  end

  scope '/__owner', module: :owner, as: :owner do
    # http_basic_authenticate_with inside controller
    concerns :owner_routes
    mount Sidekiq::Web => '/sidekiq'
  end

  root to: "public/home#index", via: :get

end
