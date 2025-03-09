class DeleteReminderRecordJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Reminder.where("reminder_date < ?", Time.zone.now).delete_all
    Rails.logger.info "現在時刻：#{Time.zone.now}"
  end
end
