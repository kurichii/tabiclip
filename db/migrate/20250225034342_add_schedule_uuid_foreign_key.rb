class AddScheduleUuidForeignKey < ActiveRecord::Migration[7.2]
  def change
    add_column :spots, :schedule_uuid, :uuid

    Spot.reset_column_information
    Spot.find_each { |s| s.update_column(:schedule_uuid, Schedule.find(s.schedule_id).uuid) }

    change_column_null :spots, :schedule_uuid, false
  end
end
