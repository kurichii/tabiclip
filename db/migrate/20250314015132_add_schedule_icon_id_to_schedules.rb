class AddScheduleIconIdToSchedules < ActiveRecord::Migration[7.2]
  def change
    add_column :schedules, :schedule_icon_id, :integer
  end
end
