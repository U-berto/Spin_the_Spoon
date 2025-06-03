Rails.application.routes.draw do
  resources :restaurants, only: [:show]
  get '/restaurants_api/:id/pick', to: 'restaurants_api#pick_restaurant', as: :pick_restaurant

  devise_for :users
  root to: "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check
end
