class CreateCheckLists < ActiveRecord::Migration[7.2]
  def change
    create_table :check_lists do |t|
      t.references :travel_book, null: false, foreign_key: true
      t.string :title, null: false
      t.timestamps
    end
  end
end
