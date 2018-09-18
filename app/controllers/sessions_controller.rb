class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    client_id = '3d4fdf55eb545a37bd25'
    client_secret = '77afeece3f073dffee29ad3e224583ea5e98e058'
    code = params['code']
    response = Faraday.post "https://github.com/login/oauth/access_token" do |req|
    req.body = { 'client_id': client_id, 'client_secret': client_secret, 'code': code }
    req.headers['Accept'] = 'application/json'
   end
   body = JSON.parse(response.body)
   session[:token] = body["access_token"]
   redirect_to root_path
 end
end
