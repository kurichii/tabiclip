Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords"
  }
  get "users/profile" => "users#show"
  get "home/index"
  resources :travel_books do
    collection do
      get "public", action: :public_travel_books
    end
    delete "delete_image", on: :member
    resources :schedules, shallow: true
    resources :check_lists, shallow: true do
      resources :list_items, only: %i[ new create edit update destroy toggle ] do
        collection do
          post :cancel # new 用
        end
        member do
          post :cancel # edit 用
          patch :toggle
        end
      end
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "home#index"
end
