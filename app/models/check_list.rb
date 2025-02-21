class CheckList < ApplicationRecord
  belongs_to :travel_book, foreign_key: :travel_book_uuid
  has_many :list_items, primary_key: :uuid, foreign_key: :check_list_uuid, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
end
