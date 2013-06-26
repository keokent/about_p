class SessionsController < ApplicationController
  before_action :already_login, only: [:new]

  def new
  end

  def callback
    auth = request.env["omniauth.auth"]
    # TODO: https://github.com/paperboy-all/all/blob/master/github/members.txtから社員のGithubデータを取得して, auth["info"]["nickname"]に該当しなかったら弾く
    user = User.find_by(github_uid: auth["uid"])
    if user
      sign_in user
      flash[:success] = "aboutPへようこそ"
      redirect_to users_path
    else
      session[:github_uid] = auth["uid"]
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
