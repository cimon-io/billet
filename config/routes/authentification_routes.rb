concern :authentification_routes do
  get '/sign_in' => 'sessions#new', as: 'sign_in'
  post '/sign_in' => 'sessions#create'
  delete '/sign_out' => 'sessions#destroy', as: 'sign_out'
  get '/sign_up' => 'registration#new', as: 'sign_up'
  post '/sign_up' => 'registration#create'
  get '/confirm' => 'confirmation#create', as: 'confirmation'
end
