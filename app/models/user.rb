class User < ApplicationRecord
  mount_uploader :icon_image, UserUploader
  has_many :user_travel_books, dependent: :destroy
  has_many :travel_books, through: :user_travel_books

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
