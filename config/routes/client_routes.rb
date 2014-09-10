concern :client_routes do
  match "/", to: "home#index", via: :get, as: 'root'
  resources :projects
end
