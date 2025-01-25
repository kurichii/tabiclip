class TravelBook < ApplicationRecord
  mount_uploader :travel_book_image, TravelBookUploader

  belongs_to :area, optional: true
  belongs_to :traveler_type, optional: true
  belongs_to :creator, class_name: "User"
  has_many :user_travel_books, dependent: :destroy
  has_many :users, through: :user_travel_books
  has_many :schedules

  validates :title, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 65_535 }
  validate :end_date_after_start_date

  scope :public_travel_books, -> { where(is_public: true) }

  def owned_by_user?(user)
    return false if user.nil?
    users.exists?(id: user.id)
  end

  private

  def end_date_after_start_date
    if start_date.present? && end_date.present? && end_date < start_date
      errors.add(:end_date, "must be after start date")
    end
  end
end
