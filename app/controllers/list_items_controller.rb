class ListItemsController < ApplicationController
  before_action :set_check_list, only: %i[ new create ]
  before_action :set_list_item, only: %i[ edit update destroy toggle]

  def new
    @list_item = @check_list.list_items.new
  end

  def create
    @list_item = @check_list.list_items.build(list_item_params)
    respond_to do |format|
      if @list_item.save
        format.turbo_stream { flash.now[:notice] = t("defaults.flash_message.created", item: ListItem.model_name.human) }
      else
        flash.now[:alert] = t("defaults.flash_message.not_created", item: ListItem.model_name.human)
        format.turbo_stream { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @list_item.update(list_item_params)
        format.turbo_stream { flash.now[:notice] = t("defaults.flash_message.updated", item: ListItem.model_name.human) }
      else
        flash.now[:alert] = t("defaults.flash_message.not_updated", item: ListItem.model_name.human)
        format.turbo_stream { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    flash.now[:notice] = t("defaults.flash_message.deleted", item: ListItem.model_name.human)
    @list_item.destroy!
  end

  def cancel
    respond_to do |format|
      if params[:id].present?
        # 編集時（edit）のキャンセル
        @list_item = ListItem.find(params[:id])
        format.turbo_stream
      else
        # 新規作成時（new）のキャンセル
        @check_list = CheckList.find(params[:check_list_id])
        format.turbo_stream { render "cancel_new" }
      end
    end
  end

  def toggle
    @list_item.update(completed: !@list_item.completed)
    render turbo_stream: turbo_stream.replace(@list_item, partial: "list_item", locals: { list_item: @list_item })
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
