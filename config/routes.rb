Rails.application.routes.draw do
  # JSON:API
  namespace :api do
    resources :halls, :movies, :seances, :reservations
  end
end
