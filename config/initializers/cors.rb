Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "*"  # Depois troca pra URL real da Vercel

    resource "*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end