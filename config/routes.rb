Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :collections, only: [:index]

  post "home", to: "home#create", as: :connect
  delete "home", to: "home#destroy", as: :disconnect

  root "home#index"
end
