class ChangeTravelBookIndex < ActiveRecord::Migration[7.2]
  def change
    remove_index :schedules, name: "index_schedules_on_travel_book_id"
    remove_index :check_lists, name: "index_check_lists_on_travel_book_id"
    remove_index :user_travel_books, name: "index_user_travel_books_on_travel_book_id"

    add_index :schedules, :travel_book_uuid
    add_index :check_lists, :travel_book_uuid
    add_index :user_travel_books, :travel_book_uuid
  end
end
