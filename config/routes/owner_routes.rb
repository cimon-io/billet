concern :owner_routes do
  match "/", to: "home#index", via: :get, as: 'root'
  resources :companies do
    resources :users
  end
end
