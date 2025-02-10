class ListItemsController < ApplicationController
  def new
    @check_list = CheckList.find(params[:check_list_id])
    @list_item = @check_list.list_items.new
  end

  def create
    @check_list = CheckList.find(params[:check_list_id])
    @list_item = @check_list.list_items.build(list_item_params)

    if @list_item.save
      flash.now[:notice] = "成功"
    else
      flash.now[:alert] = "失敗"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def list_item_params
    params.require(:list_item).permit(:title, :completed)
  end
end
