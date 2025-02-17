class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]

    if @range == "user"
      @users = User.looks(params[:word])
    else
      @posts = Post.looks(params[:word])
    end

 
    render "/searches/search_result"
  end
end
