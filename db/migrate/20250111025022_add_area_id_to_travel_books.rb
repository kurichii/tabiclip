class AddAreaIdToTravelBooks < ActiveRecord::Migration[7.2]
  def change
    add_reference :travel_books, :area, foreign_key: true
  end
end
