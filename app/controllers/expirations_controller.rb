class ExpirationsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @expirations = current_user.expirations
  end

  def new
    @expiration = Expiration.new
  end

  def create
    @expiration = current_user.expirations.new(expiration_params)
    if @expiration.save
      flash[:notice] = "賞味期限を登録しました！"
      redirect_to expirations_path
    else
      flash.now[:aleat] = "投稿できませんでした"
      render :new
    end
  end

  def edit
    @expiration = Expiration.find(params[:id])
  end

  def update
    @expiration = Expiration.find(params[:id])
    if @expiration.update(expiration_params)
      flash[:notice] = "編集できました"
      redirect_to expirations_path
    else
      flash.now[:aleat] = "編集できませんでした"
      render :edit
    end
  end

  def destroy
    @expiration = Expiration.find(params[:id])
    @expiration.destroy
    flash[:notice] = "削除しました"
    redirect_to expirations_path
  end

  private

  def correct_user
    @expiration = current_user.expirations.find_by_id(params[:id])
    redirect_to root_path unless @expiration
  end

  def expiration_params
    params.require(:expiration).permit(:name, :start_time)
  end
end
