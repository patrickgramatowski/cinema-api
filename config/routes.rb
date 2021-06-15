Rails.application.routes.draw do
  # JSON:API
  namespace :api do
    resources :halls, :movies, :seances
    
    resources :reservations do 
      resources :tickets
    end

    resources :ticket_desks, only: [:show] do
      post '/offline', to: 'reservations#create_offline'
    end
  end
end
