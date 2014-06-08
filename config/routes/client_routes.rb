concern :client_routes do
  match "/", to: "home#index", via: :get, as: 'client_root'
  resources :projects
end
