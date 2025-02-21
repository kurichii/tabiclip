class ChangeTravelBookPrimaryKey < ActiveRecord::Migration[7.2]
  def change
    remove_foreign_key :schedules, :travel_books
    remove_foreign_key :check_lists, :travel_books
    remove_foreign_key :user_travel_books, :travel_books

    execute "ALTER TABLE travel_books DROP CONSTRAINT travel_books_pkey;"
    execute "ALTER TABLE travel_books ADD PRIMARY KEY (uuid);"

    add_foreign_key :schedules, :travel_books, column: :travel_book_uuid, primary_key: :uuid
    add_foreign_key :check_lists, :travel_books, column: :travel_book_uuid, primary_key: :uuid
    add_foreign_key :user_travel_books, :travel_books, column: :travel_book_uuid, primary_key: :uuid
  end
end
