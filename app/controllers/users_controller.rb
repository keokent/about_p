class UsersController < ApplicationController
  # TODO: session[:github_id]がnilだったら/signinへリダイレクトするbefore_acitonを実装
  def new
    @user = User.new(github_id: session[:github_id])
  end
end
