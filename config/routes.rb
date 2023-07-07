Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "recipes#index"
  resources :users, only: %i[index]
  resources :foods, only: %i[index show new create edit update destroy]
  resources :recipes, only: %i[index show new create edit update destroy] do
    resources :food_recipes, only: [:create, :edit, :update, :destroy]
    member do
      patch :update_public_status
    end
  end

  get '/public_recipes', to: 'recipes#public_recipes'
end
