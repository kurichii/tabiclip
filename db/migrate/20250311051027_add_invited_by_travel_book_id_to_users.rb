class AddInvitedByTravelBookIdToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :invited_by_travel_book_id, :string
  end
end
