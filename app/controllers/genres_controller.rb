class GenresController < ApplicationController
  def show
    @genre = Genre.find(params[:id])
    @posts = @genre.posts
  end
end
