Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :collections

  post "home", to: "home#create", as: :connect
  delete "home", to: "home#destroy", as: :disconnect

  root "home#index"
end
