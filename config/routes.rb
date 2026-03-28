Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "auth/callback", to: "sessions#create"

      resources :users, only: [:show] do
        resources :snapshots, only: [:index] do
          # Rota customizada: POST /api/v1/users/:user_id/snapshots/sync
          collection do
            post :sync
          end
        end
      end
    end
  end
end