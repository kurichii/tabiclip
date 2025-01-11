class UserTravelBook < ApplicationRecord
  belongs_to :user
  belongs_to :travel_book

  validates :user_id, uniqueness: { scope: :travel_book_id }
end
