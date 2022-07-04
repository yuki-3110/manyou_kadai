Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks do
    collection do
      post :confirm
    end
    # collection do
    #   get 'search'
    # end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
