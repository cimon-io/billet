Rails.application.routes.draw do
  Dir[Rails.root.join("config/routes/**/*.rb")].each { |f| instance_eval(File.read(f)) }

  scope module: :client do
    get '/sign_in' => 'sessions#new', as: 'sign_in'
    post '/sign_in' => 'sessions#create'
    delete '/sign_out' => 'sessions#destroy', as: 'sign_out'
  end

  constraints Constraints::Subdomain.none do
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

  constraints Constraints::Subdomain.owner do
    # http_basic_authenticate_with inside controller
    scope module: :owner do
      concerns :owner_routes
    end
  end

  root to: "public/home#index", via: :get

end
