Rails.application.routes.draw do

  namespace :api do
    namespace :v0 do
      resources :forecast, only: :index
      resources :users, only: :create
      resources :sessions, only: :create
      resources :road_trip, only: :create
    end
    namespace :v1 do
      resources :munchies, only: :index
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
