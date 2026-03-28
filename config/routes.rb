Rails.application.routes.draw do
  # Todas as rotas da API ficam dentro desse namespace
  namespace :api do
    namespace :v1 do
      # GET /api/v1/users/:id
      resources :users, only: [:show]
    end
  end
end