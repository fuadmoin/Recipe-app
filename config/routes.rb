Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  root "recipes#index"
  resources :users, only: %i[index]
  resources :foods, only: %i[index show new create edit update destroy]
  resources :recipes, only: %i[index show new create edit update destroy] do
    resources :food_recipes, only: [:create, :edit, :update, :destroy]
    member do
      patch :update_public_status
    end
    get :general_shopping_list, on: :member
  end
end
