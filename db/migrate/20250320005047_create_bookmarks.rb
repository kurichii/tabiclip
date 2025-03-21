class CreateBookmarks < ActiveRecord::Migration[7.2]
  def change
    create_table :bookmarks do |t|
      t.references :user, foreign_key: true, null: false
      t.uuid :travel_book_uuid, null: false
      t.timestamps
    end

    add_foreign_key :bookmarks, :travel_books, column: :travel_book_uuid, primary_key: :uuid
    add_index :bookmarks, [:user_id, :travel_book_uuid], unique: true
  end
end
