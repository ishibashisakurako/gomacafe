class OthersController < ApplicationController

  def show
    @other = Other.find(params[:id])
    @posts = @other.posts
  end

end
