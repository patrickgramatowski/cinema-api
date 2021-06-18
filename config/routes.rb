Rails.application.routes.draw do
  # JSON:API
  namespace :api, defaults: { format: :json } do
    resources :halls, :movies, :seances, :ticket_desks

    resources :users, only: %w[show]

    resources :reservations, only: %i[index show update destroy] do 
      resources :tickets

      collection do
        post '/offline', to: 'reservations#create'
        post '/online', to: 'reservations#create_online'
      end
    end
  end

  devise_for :users,
    defaults: { format: :json },
    path: '',
    path_names: {
      sign_in: 'api/login',
      sign_out: 'api/logout',
      registration: 'api/signup'
    },
    controllers: {
      reservations: 'reservations',
      sessions: 'sessions',
      registrations: 'registrations'
    }
end
