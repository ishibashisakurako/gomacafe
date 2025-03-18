class PostCommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id]) #探してる
    comment = current_user.post_comments.new(post_comment_params) #コメントできるのはログインしてる人
    comment.post_id = post.id #コメントと投稿を紐づける
    comment.save #保存
    redirect_to post_path(post) #postのshowに飛ぶ
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
