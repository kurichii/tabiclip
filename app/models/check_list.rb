class CheckList < ApplicationRecord
  belongs_to :travel_book

  validates :title, presence: true, length: { maximum: 255 }
end
