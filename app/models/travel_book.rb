class TravelBook < ApplicationRecord
  mount_uploader :travel_book_image, TravelBookUploader

  belongs_to :area
  belongs_to :traveler_type
  has_many :user_travel_books, dependent: :destroy
  has_many :users, through: :user_travel_books

  validates :title, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 65_535 }

  def owned_by_user?(user)
    users.exists?(id: user.id)
  end
end
