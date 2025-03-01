class ChangeReminderDateToAllowNull < ActiveRecord::Migration[7.2]
  def change
    change_column_null :reminders, :reminder_date, true
  end
end
