class DeleteTravelBookId < ActiveRecord::Migration[7.2]
  def change
    remove_column :schedules, :travel_book_id, :bigint
    remove_column :check_lists, :travel_book_id, :bigint
    remove_column :user_travel_books, :travel_book_id, :bigint
    remove_column :travel_books, :id, :bigint
  end
end
