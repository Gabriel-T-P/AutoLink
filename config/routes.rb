Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  localized do
    root to: "cars#index"

    resources :cars, only: [ :index, :show ] do
      get :search, on: :collection
    end
    resources :contact_messages, only: [ :new, :create ]
  end

  namespace "api" do
    namespace "v1" do
      resources :contact_messages, only: [ :index, :show ]
      resources :sellers, only: [ :index ]
    end
  end
end
