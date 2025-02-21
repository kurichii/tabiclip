class UserTravelBook < ApplicationRecord
  belongs_to :user
  belongs_to :travel_book, foreign_key: :travel_book_uuid

  validates :user_id, uniqueness: { scope: :travel_book_uuid }
end
