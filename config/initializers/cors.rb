Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # Em desenvolvimento, aceita qualquer origem
    # Em produção, trocaremos pra URL real do Vercel
    origins "*"

    resource "*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end