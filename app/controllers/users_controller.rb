class UsersController < ApplicationController
  before_action :through_github, only: [:new]

  def new
    @user = User.new(github_id: session[:github_id])
  end

  # Before actions
  def through_github 
    redirect_to(signin_path) unless session[:github_id]
  end
end
