# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  root 'products#index'
  resources :products
  resources :tasks
  resource :cart, only: %i[show destroy] do
    post :apply_promotion
  end
  resources :cart_items, only: %i[create update destroy]
  resources :orders, only: %i[create index show]

  namespace :admin do
    resources :products
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
