class ColumnsController < ApplicationController
  def new
    @column = Column.new
  end

  def create
    @column = current_user.columns.new(column_params)
    if @column.save!
    redirect_to column_path(@column)
    else
      render :new
    end
  end

  def index
    @columns = Column.all
  end

  def show
    @column = Column.find(params[:id])
  end

  def edit
  end

  private

  def column_params
    params.require(:column).permit(:title, :body)
  end
end
