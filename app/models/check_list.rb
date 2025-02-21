class CheckList < ApplicationRecord
  belongs_to :travel_book, foreign_key: :travel_book_uuid
  has_many :list_items, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
end
