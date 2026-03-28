class Api::V1::UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    render json: user, only: [:id, :github_uid, :username, :avatar_url]
  end
end
