class AddJobIdToReminders < ActiveRecord::Migration[7.2]
  def change
    add_column :reminders, :job_id, :string
  end
end
