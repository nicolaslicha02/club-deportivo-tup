Rails.application.routes.draw do
  get "registro", to: "registrations#new"
  post "registro", to: "registrations#create"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"


  namespace :portal do
    get "dashboard", to: "dashboard#index"

    resources :activities, only: [ :index ] do
      post "enroll", on: :member
    end

    resources :membership_fees, only: [ :update ]
  end

  namespace :admin do
    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"


    resource :club_setting, only: [ :edit, :update ]

    resources :activities
    resources :member_profiles
    resources :membership_fees

    root to: "activities#index"
  end

  namespace :api do
    namespace :v1 do
      post "login", to: "sessions#create"
      resources :activities, only: [ :index, :show ]
    end
  end
end
