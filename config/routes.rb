# frozen_string_literal: true

Rails.application.routes.draw do
  root 'products#index'
  resources :products
  resources :tasks

  namespace :admin do
    resources :products
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
