require "net/http"
require "json"

class Api::V1::SessionsController < ApplicationController
  def create
    code = params[:code]
    
    token_response = exchange_code_for_token(code)
    access_token = token_response["access_token"]

    github_user = fetch_github_user(access_token)

    user = User.find_or_initialize_by(github_uid: github_user["id".to_s])
    user.update!(
      username: github_user["login"],
      avatar_url: github_user["avatar_url"],
      access_token: access_token
    )

    render json: user, only: [:id, :github_uid, :username, :avatar_url]
  end

  private

  def exchange_code_for_token(code)
    uri = URI("https://github.com/login/oauth/access_token")
    response = Net::HTTP.post_form(uri, {
      client_id: ENV["GITHUB_CLIENT_ID"],
      client_secret: ENV["GITHUB_CLIENT_SECRET"],
      code: code
    })

    # GitHub retorna em formato URL-encoded, convertemos pra hash
    URI.decode_www_form(response.body).to_h
  end

  def fetch_github_user(token)
      uri = URI("https://api.github.com/user")
      request = Net::HTTP::Get.new(uri)
      request["Authorization"] = "Bearer #{token}"
      request["Accept"] = "application/json"

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

      JSON.parse(response.body)
  end
end
