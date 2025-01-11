class CreateUserTravelBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :user_travel_books do |t|
      t.references :user, foreign_key: true
      t.references :travel_book, foreign_key: true

      t.timestamps
    end
    add_index :user_travel_books, [ :user_id, :travel_book_id ], unique: true
  end
end
