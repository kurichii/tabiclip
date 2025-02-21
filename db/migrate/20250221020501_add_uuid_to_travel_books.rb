class AddUuidToTravelBooks < ActiveRecord::Migration[7.2]
  def change
    add_column :travel_books, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_index :travel_books, :uuid, unique: true

    TravelBook.reset_column_information
    TravelBook.find_each { |travel_book| travel_book.update_column(:uuid, SecureRandom.uuid) }
  end
end
