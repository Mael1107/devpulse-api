class Api::V1::SnapshotsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    snapshots = user.snapshots.order(date: :desc)

    render json: snapshots, only: [:id, :commits_count, :repos_count, :languages, :date]
  end
end
