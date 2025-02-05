Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :shops, only: [:index, :create, :show]
      resources :items, only: [:index, :create, :show]
      resources :discounts, only: [:index, :create, :show]
      resources :combo_discounts, only: [:index, :create, :show]
      resources :orders, only: [:create, :show, :index, :update] do
        post 'pay', on: :member
      end
    end
  end

  resources :items do
    member do
      get 'buy'  # Add a 'buy' action for individual items
    end
  end

  resources :orders


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
