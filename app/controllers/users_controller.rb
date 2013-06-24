class UsersController < ApplicationController
  # TODO: index, showはログインしたユーザしか実行できないが開発のため今は緩める
  before_action :through_github, only: [:new, :create]

  def index
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    # FIX: 一時的に
    @user.github_id = session[:github_id]
    @user.job_type = 1  
    @user.section_id = 1
    if @user.save
      sign_in @user
      redirect_to users_path
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :irc_name, :birthday,
                                 :background, :hobby, :free_space)
  end
  # Before actions
  def through_github 
    redirect_to(signin_path) unless session[:github_id]
  end
end
