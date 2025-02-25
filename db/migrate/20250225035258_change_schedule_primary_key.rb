class ChangeSchedulePrimaryKey < ActiveRecord::Migration[7.2]
  def change
    remove_foreign_key :spots, :schedules

    execute "ALTER TABLE schedules DROP CONSTRAINT schedules_pkey;"
    execute "ALTER TABLE schedules ADD PRIMARY KEY (uuid);"

    add_foreign_key :spots, :schedules, column: :schedule_uuid, primary_key: :uuid
  end
end
