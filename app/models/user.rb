class User < ApplicationRecord
  mount_uploader :icon_image, UserUploader
  has_many :user_travel_books, dependent: :destroy
  has_many :travel_books, primary_key: :uuid, foreign_key: :travel_book_uuid, through: :user_travel_books
  has_many :created_travel_books, class_name: "TravelBook", foreign_key: "creator_id", dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[ line ], invite_for: 24.hours

  before_create :generate_unique_token

  def generate_unique_token
    self.token = loop do
      random_token = SecureRandom.hex(16)
      break random_token unless User.exists?(token: random_token)
    end
  end

  def social_profile(provider)
    social_profiles.select { |sp| sp.provider == provider.to_s }.first
  end

  def set_values(omniauth)
    return if provider.to_s != omniauth["provider"].to_s || uid != omniauth["uid"]
    credentials = omniauth["credentials"]
    info = omniauth["info"]

    access_token = credentials["refresh_token"]
    access_secret = credentials["secret"]
    credentials = credentials.to_json
    name = info["name"]
  end

  def set_values_by_raw_info(raw_info)
    self.raw_info = raw_info.to_json
    self.save!
  end
end
