Rails.application.routes.draw do
  devise_for :users
  # get 'recipes/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'recipes#index'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # resources :foods, only: %i[index show new create destroy]
  resources :recipes, only: %i[index show new create destroy] do
    resources :ingredients, only: [:new, :create, :destroy]    
    collection do
      get :public_recipes
      get :generate_shopping_list
    end
  end
  resources :foods, except: [:edit, :update]

  get '/general_shopping_list', to: 'foods#general'
  get 'public_recipes', to: 'recipes#public_recipes'
end
