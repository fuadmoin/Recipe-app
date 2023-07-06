Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "recipes#index"
  resources :users, only: %i[index]
  resources :recipes, only: %i[index show new create edit update destroy] do
    member do
      patch :update_public_status
    end
  end
end
