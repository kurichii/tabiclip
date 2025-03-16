class Note < ApplicationRecord
  belongs_to :travel_book

  validates :title, presence: true, length: { maximum: 20 }
  validates :body, presence: true, length: { maximum: 65_535 }
end
