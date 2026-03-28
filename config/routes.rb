Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:show] do
        # Rota aninhada: snapshots pertencem a um user
        resources :snapshots, only: [:index]
      end
    end
  end
end