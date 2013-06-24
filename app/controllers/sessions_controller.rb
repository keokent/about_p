class SessionsController < ApplicationController
  def callback
    auth = request.env["omniauth.auth"]
    user = User.find_by(github_id: auth["uid"])
    unless user
      session[:github_id] = auth["uid"]
      redirect_to users_new
    end
  end

  def destroy
  end
end
