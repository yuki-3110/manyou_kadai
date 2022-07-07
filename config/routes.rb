Rails.application.routes.draw do
  root 'users#new'
  resources :sessions, only: %i(new create destroy)
  resources :users, only: %i(new create show edit update)
  resources :tasks do
    collection do
      post :confirm
    end
  end
end
