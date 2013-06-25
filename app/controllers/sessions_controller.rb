class SessionsController < ApplicationController
  def callback
    auth = request.env["omniauth.auth"]
    # TODO: https://github.com/paperboy-all/all/blob/master/github/members.txtから社員のGithubデータを取得して, auth["info"]["nickname"]に該当しなかったら弾く
    user = User.find_by(github_id: auth["uid"])
    if user
      sign_in user
      redirect_to user_path(user)
    else
      session[:github_id] = auth["uid"]
      redirect_to new_user_path
    end
  end

  def destroy
    sign_out
    redirect_to signin_path
  end
end
