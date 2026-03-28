require "net/http"
require "json"

class GithubService
  def initialize(access_token)
    @token = access_token
  end

  # Busca repos públicos do usuário
  def fetch_repos
    get("/user/repos?per_page=100&sort=updated")
  end

  # Busca os eventos recentes (commits, PRs, etc)
  def fetch_events(username)
    get("/users/#{username}/events/public?per_page=100")
  end

  # Conta commits dos últimos 30 dias
  def count_recent_commits(username)
    events = fetch_events(username)
    events
      .select { |e| e["type"] == "PushEvent" }
      .sum { |e| e.dig("payload", "commits")&.size || 0 }
  end

  # Calcula porcentagem de cada linguagem
  def language_stats
    repos = fetch_repos
    languages = Hash.new(0)

    repos.each do |repo|
      lang = repo["language"]
      languages[lang] += 1 if lang
    end

    total = languages.values.sum.to_f
    languages.transform_values { |v| (v / total * 100).round }
  end

  private

  def get(path)
    uri = URI("https://api.github.com#{path}")
    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Bearer #{@token}"
    request["Accept"] = "application/json"
    request["User-Agent"] = "DevPulse"

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    JSON.parse(response.body)
  end
end