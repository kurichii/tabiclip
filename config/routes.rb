require "sidekiq/web"

Rails.application.routes.draw do
  Sidekiq::Web.use(Rack::Auth::Basic) do |user_id, password|
    [ user_id, password ] == [ ENV["SIDEKIQ_BASIC_ID"], ENV["SIDEKIQ_BASIC_PASSWORD"] ]
  end
  mount Sidekiq::Web, at: "/sidekiq"

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords",
    omniauth_callbacks: "users/omniauth_callbacks",
    invitations: "users/invitations"
  }
  post "/callback" => "linebot#callback"
  get "profile", to: "users#show"
  get "form", to: "static_pages#form"
  get "policy", to: "static_pages#policy"
  get "terms", to: "static_pages#terms"
  get "how_to_use", to: "static_pages#how_to_use"
  get "images/ogp.png", to: "images#ogp", as: "images_ogp"
  resources :travel_books, param: :uuid do
    collection do
      get "public", action: :public_travel_books
      get "search"
      get :bookmarks
    end
    member do
      get :share
      post "invitation"
      get "invitation/accept/:invitation_token", to: "travel_books#accept", as: "accept"
      delete "delete_owner"
    end
    delete "delete_image", on: :member
    resources :schedules, param: :uuid, shallow: true do
      collection do
        get :map
      end
    end
    resources :check_lists, param: :uuid, shallow: true do
      resources :list_items, only: %i[ new create edit update destroy toggle ] do
        resources :reminders, only: %i[ create update clear_reminder ] do
          member do
            patch :clear_reminder
          end
        end
        collection do
          post :cancel # new 用
        end
        member do
          post :cancel # edit 用
          patch :toggle
        end
      end
    end
    resources :notes, param: :uuid, shallow: true
  end
  resources :bookmarks, only: %i[ create destroy ]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "static_pages#top"
end
