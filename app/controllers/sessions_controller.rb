class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    response = Faraday.post "https://github.com/login/oauth/access_token" do |req|
    req.body = { 'client_id': GITHUB_CLIENT_ID, 'client_secret': GITHUB_SECRET, 'code': code }
    req.headers['Accept'] = 'application/json'
   end
 end
end
