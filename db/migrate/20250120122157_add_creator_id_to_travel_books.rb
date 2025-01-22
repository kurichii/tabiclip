class AddCreatorIdToTravelBooks < ActiveRecord::Migration[7.2]
  def change
    add_reference :travel_books, :creator, null: false, foreign_key: { to_table: :users }
  end
end
