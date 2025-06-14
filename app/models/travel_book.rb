class TravelBook < ApplicationRecord
  mount_uploader :travel_book_image, TravelBookUploader

  belongs_to :area, optional: true
  belongs_to :traveler_type, optional: true
  belongs_to :creator, class_name: "User"

  has_many :user_travel_books, dependent: :destroy
  has_many :users, through: :user_travel_books
  has_many :schedules, dependent: :destroy
  has_many :check_lists, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 65_535 }
  validate :end_date_after_start_date

  scope :public_travel_books, -> { where(is_public: true).includes(:users).order(created_at: :desc) }

  def owned_by_user?(user)
    return false if user.nil?
    users.exists?(id: user.id)
  end

  def sorted_schedules
    schedules.includes(:spot, :schedule_icon).sort_by { |schedule| schedule.start_date || DateTime.new(0) }
  end

  # ransackで検索に使用するカラムを記述
  def self.ransackable_attributes(auth_object = nil)
    [ "area_id", "traveler_type_id" ]
  end

  # トークン生成のためのメソッド
  def generate_token
    self.invitation_token = Devise.friendly_token
    update(invitation_token: self.invitation_token)
  end

  private

  def end_date_after_start_date
    if start_date.present? && end_date.present? && end_date < start_date
      errors.add(:end_date, :end_date_after_start_date)
    end
  end
end
