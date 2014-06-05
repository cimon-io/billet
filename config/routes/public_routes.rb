concern :public_routes do
  match "/", to: "home#index", via: :get, as: 'public_home'
end