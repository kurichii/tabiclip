class CreateScheduleIcons < ActiveRecord::Migration[7.2]
  def change
    create_table :schedule_icons do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
