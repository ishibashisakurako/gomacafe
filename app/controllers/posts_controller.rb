class PostsController < ApplicationController
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
      flash[:notice] = "投稿できませんでした"
      render :new #失敗したらnewに飛ぶ
    end
  end
  

  def index
    @posts = Post.publish_posts.page(params[:page]) #全てを表示する
  end


  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new #コメント投稿できるよ
  end


  def edit
    @post = Post.find(params[:id])
    unless @post.id == current_user.id
      redirect_to posts_path
    end
  end

  
  def update
    post = Post.find(params[:id])
    unless @user.id == current_user
      redirect_to post_path
    end

    if post.update(post_params)
    redirect_to post_path(post.id)
    else
      flash[:notice] = "編集できませんでした"
      @post = Post.find(params[:id])
      render :edit
    end
  end


  def destroy
    post = Post.find(params[:id]) # 1件取得
    post.destroy # 削除
    redirect_to user_path #マイページへ飛ぶ
  end


  private
  def post_params
    params.require(:post).permit(:status, :title, :image, :introduction, :material, :recipe, :point)
  end


end
