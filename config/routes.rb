Rails.application.routes.draw do
  resources :restaurants, only: [:show]
  resources :parties, only: [:create, :show] do
  resource :roulette, only: :show
  end
   resources :parties, only: [], param: :pin do
    member do
      get :join
    end
  end
  # resources :friends, only: [:index, :show, :create]

  devise_for :users
  root to: "pages#home"
  
  get "/profile", to: "users#show", as: :profile  
  get '/restaurants_api/:id/pick', to: 'roulettes#pick_restaurant', as: :pick_restaurant
  get "up" => "rails/health#show", as: :rails_health_check
end

