class UsersController < ApplicationController
  before_action :authenticate_user!

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
  
  private

  def user_params
  params.require(:user).permit(:name, :profile_image, :introduction)
  end

end