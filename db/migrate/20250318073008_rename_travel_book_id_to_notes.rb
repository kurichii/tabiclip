class RenameTravelBookIdToNotes < ActiveRecord::Migration[7.2]
  def change
    remove_foreign_key :notes, :travel_books

    rename_column :notes, :travel_book_id, :travel_book_uuid

    add_foreign_key :notes, :travel_books, column: :travel_book_uuid, primary_key: :uuid
  end
end
