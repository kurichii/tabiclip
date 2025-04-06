class CheckList < ApplicationRecord
  belongs_to :travel_book
  has_many :list_items, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
end
