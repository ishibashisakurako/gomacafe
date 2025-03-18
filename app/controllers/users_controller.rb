class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:guest_login]
  before_action :correct_user, only: [:favorite]

  def index
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end

  def edit
    user = User.find(params[:id])
  unless user.id == current_user.id
    redirect_to user_path(current_user)
  end
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id]) #ユーザーの取得
    unless @user.id == current_user.id
     redirect_to user_path(current_user)
    end
    if @user.update(user_params) #ユーザーのアップデート
      redirect_to user_path(@user.id) #ユーザー詳細へのパス
    else
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id]) # 1件取得
    user.destroy # 削除
    redirect_to '/users/sign_up'
  end

  def favorite
    @user = User.find(params[:user_id])
    @favorite_posts = @user.favorite_posts
    #@favorite_posts.destroy # お気に入りから指定した投稿を削除
  end

  def guest_login
    @user = User.guest
    sign_in(@user)
    redirect_to posts_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def columns
    @user = User.find(params[:user_id])
    @columns = @user.columns.where(status: "publish")
  end

  private

  def user_params
  params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def correct_user
    @user = User.find(params[:user_id])
    redirect_to root_path if @user != current_user
  end

end