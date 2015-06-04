concern :authentification_routes do
  get '/sign_in' => 'sessions#new', as: 'sign_in'
  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match '/logout', to: 'sessions#destroy', via: [:get, :post]
end
