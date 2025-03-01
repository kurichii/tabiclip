class RemindersController < ApplicationController
  before_action :set_reminder, only: %i[ update clear_reminder ]

  def update
    if @reminder.update(reminder_params)
      flash.now[:notice] = t("flash_message.reminder.updated", item: Reminder.model_name.human)
    else
      render "not_update"
    end
  end

  def clear_reminder
    if @reminder.update(reminder_date: nil)
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
