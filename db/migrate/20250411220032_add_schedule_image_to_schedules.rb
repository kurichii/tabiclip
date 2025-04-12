class AddScheduleImageToSchedules < ActiveRecord::Migration[7.2]
  def change
    add_column :schedules, :schedule_image, :string
  end
end
