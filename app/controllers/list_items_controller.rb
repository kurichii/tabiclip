class ListItemsController < ApplicationController

  def create
    @check_list = CheckList.find(params[:check_list_id])
    @list_item = @check_list.list_items.build(list_item_param)

    if @list_item.save
      redirect_to check_list_path(@check_list)
    else
      render "check_lists/show"
    end
  end

  private

  def list_item_param
    params.require(:list_item).permit(:title, :completed)
  end
end
