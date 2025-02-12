class ChangeStartDateColumnToTravelBooks < ActiveRecord::Migration[7.2]
  def change
    change_column :travel_books, :start_date, :date
    change_column :travel_books, :end_date, :date
  end
end
