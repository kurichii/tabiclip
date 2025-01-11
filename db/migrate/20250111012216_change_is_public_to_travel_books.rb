class ChangeIsPublicToTravelBooks < ActiveRecord::Migration[7.2]
  def change
    change_column_default(:travel_books, :is_public, from: nil, to: false)
  end
end
