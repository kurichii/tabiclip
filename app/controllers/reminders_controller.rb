class RemindersController < ApplicationController
  def create
    @list_item = ListItem.find(params[:list_item_id])
    @check_list = @list_item.check_list
    @reminder = @list_item.build_reminder(reminder_params)

    if @reminder.save
      flash.now[:notice] = t("defaults.flash_message.created", item: Reminder.model_name.human)
    else
      render "not_create"
    end
  end

  def update
    @reminder = Reminder.find(params[:id])
    @list_item = @reminder.list_item
    @check_list = @list_item.check_list

    if @reminder.update(reminder_params)
      flash.now[:notice] = t("defaults.flash_message.updated", item: Reminder.model_name.human)
    else
      render "not_update"
    end
  end

  def clear_reminder
    @reminder = Reminder.find(params[:id])
    @list_item = @reminder.list_item
    if @reminder.update(reminder_date: nil)
      flash.now[:notice] = "リマインダーを解除しました"
    else
      flash.now[:alert] = "リマインダーを解除できませんでした"
    end
  end

  private

  def reminder_params
    params.require(:reminder).permit(:reminder_date)
  end
end
