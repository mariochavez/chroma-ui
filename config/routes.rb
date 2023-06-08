Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :collections
  resources :embeddings, only: [:new, :create, :destroy]
  resources :peek_embeddings, only: [:new, :create]
  resources :query_embeddings, only: [:new, :create]

  post "home", to: "home#create", as: :connect
  delete "home", to: "home#destroy", as: :disconnect

  root "home#index"
end
