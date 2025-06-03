Rails.application.routes.draw do
  resources :restaurants, only: [:show]

  devise_for :users
  root to: "pages#home"
  get '/restaurants_api/:id/pick', to: 'restaurants_api#pick_restaurant', as: :pick_restaurant

  get "up" => "rails/health#show", as: :rails_health_check
end
