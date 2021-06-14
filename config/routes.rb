Rails.application.routes.draw do
  # JSON:API
  namespace :api do
    resources :halls, :movies, :seances, :reservations, :ticket_desks
    resources :tickets, only: %i[show index]
  end
end
