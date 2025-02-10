class ListItemsController < ApplicationController
  before_action :set_check_list, only: %i[ new create ]
  before_action :set_list_item, only: %i[ edit update destroy]

  def new
    @list_item = @check_list.list_items.new
  end

  def create
    @list_item = @check_list.list_items.build(list_item_params)

    if @list_item.save
      flash.now[:notice] = "成功"
    else
      flash.now[:alert] = "失敗"
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @list_item.update(list_item_params)
      flash.now[:notice] = "成功"
    else
      flash.now[:alert] = "失敗"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @list_item.destroy!
  end

  private

  def set_check_list
    @check_list = CheckList.find(params[:check_list_id])
  end

  def set_list_item
    @list_item = ListItem.find(params[:id])
  end

  def list_item_params
    params.require(:list_item).permit(:title, :completed)
  end
end
