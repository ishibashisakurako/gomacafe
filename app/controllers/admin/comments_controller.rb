class Admin::CommentsController < ApplicationController

  layout 'admin'
  before_action :authenticate_admin!

  
def index
  @post_comments = PostComment.all
end


def destroy
  PostComment.find(params[:id]).destroy
  redirect_to admin_comments_path
end



end