class RemindersController < ApplicationController
  def create
    @list_item = ListItem.find(params[:list_item_id])
    @check_list = @list_item.check_list
    @reminder = @list_item.build_reminder(reminder_params)
    if @reminder.save
      redirect_to check_list_path(@check_list), notice: t("defaults.flash_message.created", item: Reminder.model_name.human)
    else
      redirect_to check_list_path(@check_list), alert: t("defaults.flash_message.not_created", item: Reminder.model_name.human)
    end
  end

  def update
    @list_item = ListItem.find(params[:id])
    @reminder = @list_item.reminder
    @check_list = @list_item.check_list
    if @reminder.update(reminder_params)
      redirect_to check_list_path(@check_list), notice: t("defaults.flash_message.updated", item: Reminder.model_name.human)
    else
      redirect_to check_list_path(@check_list), alert: t("defaults.flash_message.not_updated", item: Reminder.model_name.human)
    end
  end

  private
  def reminder_params
    params.require(:reminder).permit(:reminder_date)
  end
end
