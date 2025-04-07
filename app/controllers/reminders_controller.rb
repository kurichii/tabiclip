class RemindersController < ApplicationController
  before_action :set_reminder, only: %i[ update clear_reminder ]

  def create
    @list_item = ListItem.find(params[:list_item_id])
    @check_list = @list_item.check_list
    @reminder = @list_item.build_reminder(reminder_params)

    if @reminder.save
      flash.now[:notice] = t("flash_message.reminder.created", item: Reminder.model_name.human)
      job_set
    else
      render "not_create"
    end
  end

  def update
    if @reminder.update(reminder_params)
      flash.now[:notice] = t("flash_message.reminder.updated", item: Reminder.model_name.human)
      JobDeleteService.call(@reminder.job_id) if @reminder.job_id
      job_set
    else
      render "not_update"
    end
  end

  def clear_reminder
    @reminder.assign_attributes(reminder_date: nil)
    # reminder_dateをpresence: trueにしているためバリデーションを回避させる
    if @reminder.save(validate: false)
      flash.now[:notice] = t("flash_message.reminder.canceled", item: Reminder.model_name.human)
      JobDeleteService.call(@reminder.job_id) if @reminder.job_id
      # reminder_dateをpresence: trueにしているためバリデーションを回避させる
      @reminder.update_column(:job_id, nil)
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

  def job_set
    job = ReminderPushJob.set(wait_until: @reminder.reminder_date).perform_later(@list_item.id)
    @reminder.update(job_id: job.job_id)
  end
end
