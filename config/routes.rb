Rails.application.routes.draw do
  # JSON:API
  namespace :api, defaults: { format: :json } do
    resources :halls, :movies, :seances, :ticket_desks

    resources :users, only: %w[show]

    resources :reservations, only: %i[index show update destroy] do 
      resources :tickets, only: %i[show index]

      collection do
        get '/uindex', to: 'reservations#user_index'
        get '/ushow/:id', to: 'reservations#user_show'
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
      tickets: 'tickets',
      halls: 'halls',
      movies: 'movies',
      ticket_desks: 'ticket_desks',
      seances: 'seances',
      sessions: 'sessions',
      registrations: 'registrations'
    }
end
