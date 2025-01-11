class AddTravelerTypeIdToTravelBooks < ActiveRecord::Migration[7.2]
  def change
    add_reference :travel_books, :traveler_type, foreign_key: true
  end
end
