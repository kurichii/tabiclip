class Schedule < ApplicationRecord
  belongs_to :travel_book

  validates :title, presence: true, length: { maximum: 255 }
  validates :memo, length: { maximum: 65_535 }
  validates :budged, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :end_date, comparison: { greater_than: :start_date }
end
