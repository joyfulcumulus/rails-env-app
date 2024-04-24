Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "pages#home"

  resources :challenges do
    member do
      get 'locations'
      get 'points_history'
      get 'recycled_history'
      patch 'subscribe'
      patch 'unsubscribe'
      post 'join'
    end
  end

  resources :chatrooms, only: %i[index show create] do
    resources :messages, only: :create
  end

  namespace :admin do
    resources :challenge_events
  end

  resources :challenge_events, only: [] do
    resources :actions, only: %i[new create]
  end

  resources :claims, only: %i[new create]
end
