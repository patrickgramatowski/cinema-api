Rails.application.routes.draw do
  # JSON:API
  namespace :api do
    resources :halls, :movies, :seances
    resources :ticket_desks do
      resources :reservations, :tickets
    end
  end
end
