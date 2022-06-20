Rails.application.routes.draw do
  root 'public_recipes#index'
  get 'public_recipes', to: 'public_recipes#index'

  resources :users
  resources :recipes, only: %i[index show new create destroy] do
    resources :recipe_foods, only: %i[create destroy]
  end
  resources :foods, only: %i[index show new create destroy]
  resources :foods, only: %i[index new create destroy] do
    resources :recipe_foods, only: %i[create destroy]
  end
end
