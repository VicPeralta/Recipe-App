Rails.application.routes.draw do
  devise_for :users
  root 'public_recipes#index'
  resources :public_recipes, only:[:index]
  resources :shopping_list, only: [:index]
  resources :users
  resources :recipes, only: %i[index show new create destroy update] do
    resources :recipe_foods, only: %i[new create destroy update edit] 
  end
  resources :foods, only: %i[index show new create destroy]
end
