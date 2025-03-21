class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :travel_book, foreign_key: :travel_book_uuid, primary_key: :uuid
end
