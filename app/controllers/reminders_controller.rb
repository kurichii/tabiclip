# SupportRequest/20250304
class RemindersController < ApplicationController
  before_action :set_reminder, only: %i[ update clear_reminder ]

  def create
    @list_item = ListItem.find(params[:list_item_id])
    @check_list = @list_item.check_list
    @reminder = @list_item.build_reminder(reminder_params)

    if @reminder.save
      ReminderPushJob.set(wait_until: @reminder.reminder_date).perform_later(@list_item.id)
      flash.now[:notice] = t("flash_message.reminder.created", item: Reminder.model_name.human)
    else
      render "not_create"
    end
  end

  def update
    if @reminder.update(reminder_params)
      ReminderPushJob.set(wait_until: @reminder.reminder_date).perform_later(@list_item.id)
      flash.now[:notice] = t("flash_message.reminder.updated", item: Reminder.model_name.human)
    else
      render "not_update"
    end
  end

  def clear_reminder
    @reminder.assign_attributes(reminder_date: nil)
    # バリデーションをスキップ
    if @reminder.save(validate: false)
      flash.now[:notice] = t("flash_message.reminder.canceled", item: Reminder.model_name.human)
    else
      flash.now[:alert] = t("flash_message.reminder.not_canceled", item: Reminder.model_name.human)
    end
  end

  private

  def set_reminder
    @reminder = Reminder.find(params[:id])
    @list_item = @reminder.list_item
  end

  def reminder_params
    params.require(:reminder).permit(:reminder_date)
  end
end
