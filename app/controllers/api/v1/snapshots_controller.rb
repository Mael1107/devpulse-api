class Api::V1::SnapshotsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    snapshots = user.snapshots.order(date: :desc)

    render json: snapshots, only: [:id, :commits_count, :repos_count, :languages, :date]
  end

  def sync
    user = User.find(params[:user_id])
    github = GithubService.new(user.access_token)

    repos = github.fetch_repos
    commits = github.count_recent_commits(user.username)
    languages = github.language_stats

    # Cria ou atualiza o snapshot de hoje
    snapshot = user.snapshots.find_or_initialize_by(date: Date.today)
    snapshot.update!(
      commits_count: commits,
      repos_count: repos.size,
      languages: languages
    )

    render json: snapshot, only: [:id, :commits_count, :repos_count, :languages, :date]
  end
end
