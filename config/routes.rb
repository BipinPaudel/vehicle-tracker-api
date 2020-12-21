Rails.application.routes.draw do
  devise_for :users


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      devise_scope :user do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
        delete "log_out", to: "sessions#destroy"
      end
      resources :categories
      resources :vehicles
      resources :maintenances
      get '/maintenances/vehicles/:vehicle_id', to: 'maintenances#list_by_vehicle'
    end
  end
end
