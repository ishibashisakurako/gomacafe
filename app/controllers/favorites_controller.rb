class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: post.id)
    favorite.save
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite =current_user.favorites.find_by(post_id: post.id)
    favorite.destroy
    redirect_back(fallback_location: root_url)
  end

end
