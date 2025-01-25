class Schedule < ApplicationRecord
  belongs_to :travel_book

  validates :title, presence: true, length: { maximum: 255 }
  validates :memo, length: { maximum: 65_535 }
  validates :budged, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    if start_date.present? && end_date.present? && end_date < start_date
      errors.add(:end_date, "must be after start date")
    end
  end
end
