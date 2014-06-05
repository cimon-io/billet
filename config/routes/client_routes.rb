concern :client_routes do
  match "/", to: "home#index", via: :get, as: 'client_home'
  resources :projects
end
