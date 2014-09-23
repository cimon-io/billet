Rails.application.routes.draw do
  Dir[Rails.root.join("config/routes/**/*.rb")].each { |f| instance_eval(File.read(f)) }

  constraints Clearance::Constraints::SignedOut.new do
    root to: "public/home#index", as: :signed_out
  end

  mount Sidekiq::Web => '/sidekiq'

  root to: "public/home#index", via: :get

end
