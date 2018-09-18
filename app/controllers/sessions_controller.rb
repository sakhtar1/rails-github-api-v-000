class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    response = Faraday.post "https://github.com/login/oauth/access_token" do |req|
      client_id = ENV['GITHUB_CLIENT_ID']
      client_secret = ENV['GITHUB_SECRET']
      code = params['code']
      req.body = { 'client_id': client_id, 'client_secret': client_secret, 'code': code }
      req.headers['Accept'] = 'application/json'
      redirect_uri="http://localhost:3000/auth"
   end
   body = JSON.parse(response.body)
   session[:token] = body["access_token"]
   redirect_to root_path
 end
end
