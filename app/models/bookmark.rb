class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :travel_book
end
