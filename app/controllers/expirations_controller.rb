class ExpirationsController < ApplicationController

  def index
    @expirations = current_user.expirations
  end

  def new
    @expiration = Expiration.new
  end

  def create
    @expiration = current_user.expirations.new(expiration_params)
    if @expiration.save
      flash[:notice] = "投稿できました"
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

  def expiration_params
    params.require(:expiration).permit(:name, :start_time)
  end
end
