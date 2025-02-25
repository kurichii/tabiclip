class ChangeScheduleIndex < ActiveRecord::Migration[7.2]
  def change
    remove_index :spots, name: "index_spots_on_schedule_id"

    add_index :spots, :schedule_uuid
  end
end
