# frozen_string_literal: true

Rails.application.routes.draw do
  root 'products#index'
  resources :products
  resources :tasks
  resource :cart, only: [:show, :destroy]
  resources :cart_items, only: [:create, :update, :destroy]

  namespace :admin do
    resources :products
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
