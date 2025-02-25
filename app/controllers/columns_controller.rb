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
    params.require(:column).permit(:title, :body)
  end
end
