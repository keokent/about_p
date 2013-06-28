class SessionsController < ApplicationController
  before_action :already_login, only: [:new]

  def new
  end

  def callback
    auth = request.env["omniauth.auth"]
    unless GithubMember.paperboy? auth["info"]["nickname"]
      redirect_to signin_path
      return
    end

    user = User.find_by(github_uid: auth["uid"])
    if user
      sign_in user
      flash[:success] = "aboutPへようこそ"
      redirect_to users_path
    else
      session[:github_uid] = auth["uid"]
      session[:github_nickname] = auth["info"]["nickname"]
      redirect_to new_user_path
    end
  end

  def destroy
    sign_out
    redirect_to signin_path
  end

  private
  def already_login
    redirect_to users_path if signed_in?
  end
end
