concern :authentification_routes do
  get '/sign_in' => 'sessions#new', as: 'in'
  match '/auth/:provider', to: 'sessions#create', as: 'provider', via: [:get, :post]
  match '/auth/:provider/callback', to: 'sessions#create', as: 'callback', via: [:get, :post]
  match '/sign_out', to: 'sessions#destroy', as: 'out', via: [:get, :post]
end
