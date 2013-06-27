# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  before_action :halfway_creation, except: [:new, :create] 
  before_action :ppb_member, only: [:new, :create]
  before_action :no_signed_in_user, only: [:new, :create]
  before_action :through_github, only: [:new, :create]
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :show]
  before_action :correct_user, only: [:edit, :update]

  def index
    @sections = Section.all
  end

  def new
    @sections = Section.all
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @section = Section.find_by(id: params[:user][:section])
    @user = @section.users.build(user_params)
    @user.github_uid = session[:github_uid]
    @user.github_name = session[:github_nickname]
    if @user.save
      sign_in @user
      flash[:success] = "aboutPへようこそ"
      session[:github_uid] = nil
      session[:github_nickname] = nil
      session[:realname] = nil
      redirect_to users_path
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      sign_in @user
      flash[:success] = "プロフィールを更新しました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :irc_name, :face_image, :job_type,  :birthday, :birthplace, :married, :background, :ppb_join, :ppb_carrier, :hometown, :twitter_id, :blog_url, :hobby, :favorite_food, :favorite_book, :club, :strong_point, :free_space) 
  end
  # Before actions
  
  def signed_in_user
    redirect_to signin_url, notice: "サインインしてください" unless signed_in?
  end

  def no_signed_in_user
    redirect_to users_path if signed_in?
  end
  
  def ppb_member
    members = JSON.parse(open("#{Rails.root}/tmp/ppb_members.json").read)

    if members.has_key? session[:github_nickname]
      session[:realname] = members[session[:github_nickname]] 
    else
      flash[:error] = "ペパボの人じゃないひとは入れません！"
      redirect_to signin_path 
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(users_path) unless current_user?(@user)
  end

  def halfway_creation
    user = User.find_by(github_uid: session[:github_uid])
    redirect_to(new_user_path) if session[:github_uid] != nil && user == nil
  end

  def through_github 
    redirect_to(signin_path) unless session[:github_uid]
  end
end
