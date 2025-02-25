class AddUuidToSchedules < ActiveRecord::Migration[7.2]
  def change
    add_column :schedules, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_index :schedules, :uuid, unique: true

    Schedule.reset_column_information
    Schedule.find_each { |schedule| schedule.update_column(:uuid, SecureRandom.uuid) }
  end
end
