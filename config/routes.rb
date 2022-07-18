Rails.application.routes.draw do
  root 'users#new'
  resources :sessions, only: %i(new create destroy)
  resources :users, only: %i(index new create show edit update) 
  resources :labels

  namespace :admin do
    resources :users
  end

  resources :tasks do
    collection do
      post :confirm
    end
  end
  # resources :middles, only: %i(:create, :destroy)
end
