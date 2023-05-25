# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'pages#index'

  resources :users, only: %i[new create edit update] do
    resources :windows, only: %i[index create destroy]
  end
  resource :session, only: %i[new create destroy]

  namespace :admin do 
    resources :users, only: %i[index edit update destroy] do # new create
      resources :windows, only: %i[index create destroy]
    end
  end
end
