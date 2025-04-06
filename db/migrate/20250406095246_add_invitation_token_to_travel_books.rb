class AddInvitationTokenToTravelBooks < ActiveRecord::Migration[7.2]
  def change
    add_column :travel_books, :invitation_token, :string
    add_index :travel_books, :invitation_token, unique: true
  end
end
