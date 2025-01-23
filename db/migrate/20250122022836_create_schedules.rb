class CreateSchedules < ActiveRecord::Migration[7.2]
  def change
    create_table :schedules do |t|
      t.references :travel_book, null: false, foreign_key: true
      t.string :title, null: false
      t.integer :budged, default: 0
      t.text :memo
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
  end
end
