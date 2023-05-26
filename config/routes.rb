# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'pages#index'

  resources :users, only: %i[new create edit update]
  resources :appointments, only: %i[index create destroy]
  resources :windows, only: %i[index create destroy]
  resource :session, only: %i[new create destroy]

  namespace :admin do 
    resources :users, only: %i[index edit update destroy]  # new create
    resources :windows, only: %i[index create destroy]
    resources :appointments, only: %i[index create destroy]
  end
end
