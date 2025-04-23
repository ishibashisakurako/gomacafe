class ColumnsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :publish_check, only: [:show]

  def new
    @column = Column.new
  end

  def create
    @column = current_user.columns.new(column_params)
    if @column.save
      redirect_to column_path(@column)
    else
      render :new
    end
  end

  def index
    @columns = Column.publish_columns.order(created_at: :desc).page(params[:page])
    @user = current_user
  end

  def show
    @user = current_user
  end

  def edit
    @column = Column.find(params[:id])
  end

  def update
    @column = Column.find(params[:id])
    @column.update(column_params)
    redirect_to column_path(@column)
  end

  def destroy
    column = Column.find(params[:id])
    column.destroy
    redirect_to columns_path
  end

  private

  def column_params
    params.require(:column).permit(:title, :body, :status)
  end

  def correct_user
    @column = current_user.columns.find_by_id(params[:id])
    redirect_to root_path unless @column
  end

  def publish_check
    @column = Column.find(params[:id])
    if @column.status != "publish" && @column.user != current_user
      redirect_to root_path
    end
  end
end
