class CreateTravelBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :travel_books do |t|
      t.string :title, null: false
      t.text :description
      t.boolean :is_public, null: false
      t.date :start_date
      t.date :end_date
    end
  end
end
