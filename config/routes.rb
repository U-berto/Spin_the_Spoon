Rails.application.routes.draw do
  get 'users/update'
  resources :restaurants, only: [:show]
  resources :users, only: [:update]
  resources :parties, only: [:create, :show] do
  resource :roulette, only: :show
  end
   resources :parties, only: [], param: :pin do
    member do
      get :join
    end
  end

  # resources :friends, only: [:index, :show, :create]
  resources :user_parties, only: [:create, :index] do
    member do
      patch :accept
      patch :decline
    end
  end

  devise_for :users
  get "/my_party", to: "parties#my_party", as: :my_party
  root to: "pages#home"

  get "/profile", to: "users#show", as: :profile
  get '/restaurants_api/:id/pick', to: 'roulettes#pick_restaurant', as: :pick_restaurant
  get "up" => "rails/health#show", as: :rails_health_check
end
