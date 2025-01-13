class AddTravelBookImageToTravelBooks < ActiveRecord::Migration[7.2]
  def change
    add_column :travel_books, :travel_book_image, :string
  end
end
