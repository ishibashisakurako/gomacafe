class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  #ログイン認証が済んでないいないユーザーがアクセスしてきた場合、ログインページに戻す

  def create #userがフォローした時
    user = User.find(params[:user_id]) #フォローしたいuserを特定して探してくる
    current_user.follow(user) #current_userがそのuserをフォロー
    redirect_to request.referer #フォローボタンを押した後、同じページに戻る
  end

  def destroy #フォロー解除したとき
    user = User.find(params[:user_id]) #フォロー解除対象のuserを特定
    current_user.unfollow(user) #current_userがそのユーザーのフォローを解除
    redirect_to request.referer #フォロー解除ボタンを押した後、元のページに戻る
  end

  def followings #フォローしているuser/indexを表示
    user = User.find(params[:user_id]) #フォローしているuserを探してきてる
    @users = user.followings #そのuserがフォローしているuserを表示
  end

  def followers #フォロワーのindexを表示
    user = User.find(params[:user_id]) #フォロワーを特定
    @users = user.followers #フォロワーを表示
  end

end
