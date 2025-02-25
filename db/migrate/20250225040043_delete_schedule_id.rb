class DeleteScheduleId < ActiveRecord::Migration[7.2]
  def change
    remove_column :spots, :schedule_id, :bigint

    remove_column :schedules, :id, :bigserial
  end
end
