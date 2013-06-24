class SessionsController < ApplicationController
  def callback
    auth = request.env["omniauth.auth"]
    # TODO: https://github.com/paperboy-all/all/blob/master/github/members.txtから社員のGithubデータを取得して, auth["info"]["nickname"]に該当しなかったら弾く
    user = User.find_by(github_id: auth["uid"])
    unless user
      # 新規ユーザ作成
      session[:github_id] = auth["uid"]
      redirect_to new_user_path
    else
      # 認証成功 User#indexに遷移
    end
  end

  def destroy
  end
end
