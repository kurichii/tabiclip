class TravelBook < ApplicationRecord
  has_many :user_travel_books, dependent: :destroy
  has_many :users, through: :user_travel_books

  validates :title, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 65_535 }
end
