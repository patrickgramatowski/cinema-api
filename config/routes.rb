Rails.application.routes.draw do
  # JSON:API
  namespace :api do
    resources :halls, :movies, :seances, :ticket_desks

    resources :reservations, only: %i[index show update destroy] do 
      resources :tickets

      collection do
        post '/offline', to: 'reservations#create'
        post '/online', to: 'reservations#create_online'
      end
    end
  end
end
