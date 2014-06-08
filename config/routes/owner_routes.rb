concern :owner_routes do
  match "/", to: "home#index", via: :get, as: 'owner_root'
  resources :companies do
    resources :users
  end
end
