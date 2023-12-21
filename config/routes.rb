Rails.application.routes.draw do
  devise_for :users
  # get 'recipes/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'recipes#index'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  resources :foods, only: %i[index show new create destroy]
  resources :recipes, only: %i[index show new create destroy] do
    collection do
      get :public_recipes
  end
end
  get 'public_recipes', to: 'recipes#public_recipes'
  
  
  resources :general_shopping_list, only: %i[index]
  # Defines the root path route ("/")
  # root "posts#index"
  get "up" => "rails/health#show", as: :rails_health_check
end
