class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create #投稿したデータを保存
    @post = Post.new(post_params) #新規投稿できるよ
    @post.user_id = current_user.id #userとpostを紐付ける
    if @post.save #もし保存したとき
      flash[:notice] = "投稿しました！"
      redirect_to post_path(@post.id) #成功なら詳細に飛ぶ
    else
      render :new #失敗したらnewに飛ぶ
    end
  end
  
  def index
    @posts = Post.publish_posts.order(created_at: :desc).page(params[:page]).per(9) #全てを表示する
    @genres = Genre.all
    @others = Other.all
    @user = current_user
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new #コメント投稿できるよ
  end

  def edit
    #@post = Post.find(params[:id])
    #unless @post.user == current_user
    #  redirect_to posts_path
    #end
  end

  def update
    #post = Post.find(params[:id])
    #unless @usee == current_user.id
    #  redirect_to post_path
    #end

    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      flash[:notice] = "編集できませんでした"
      #@post = Post.find(params[:id])
      render :edit
    end
  end

  def destroy
    #post = Post.find(params[:id]) # 1件取得
    @post.destroy # 削除
    redirect_to user_path(current_user) #マイページへ飛ぶ
  end
 
  def tag_list
    @genres = Genre.all
  end

  private
  def post_params
    params.require(:post).permit(:status, :title, :image, :amount, :introduction, :material, :recipe, :point, :genre_id, :other_id, :star)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_path
    end
  end
end
