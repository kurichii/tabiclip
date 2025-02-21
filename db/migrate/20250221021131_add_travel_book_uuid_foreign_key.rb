class AddTravelBookUuidForeignKey < ActiveRecord::Migration[7.2]
  def change
    add_column :schedules, :travel_book_uuid, :uuid
    add_column :check_lists, :travel_book_uuid, :uuid
    add_column :user_travel_books, :travel_book_uuid, :uuid

    Schedule.reset_column_information
    Schedule.find_each { |s| s.update_column(:travel_book_uuid, TravelBook.find(s.travel_book_id).uuid) }

    CheckList.reset_column_information
    CheckList.find_each { |c| c.update_column(:travel_book_uuid, TravelBook.find(c.travel_book_id).uuid) }

    UserTravelBook.reset_column_information
    UserTravelBook.find_each { |ut| ut.update_column(:travel_book_uuid, TravelBook.find(ut.travel_book_id).uuid) }

    change_column_null :schedules, :travel_book_uuid, false
    change_column_null :check_lists, :travel_book_uuid, false
    change_column_null :user_travel_books, :travel_book_uuid, false
  end
end
