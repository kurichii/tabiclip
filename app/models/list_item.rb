class ListItem < ApplicationRecord
  belongs_to :check_list, foreign_key: :check_list_uuid
  has_one :reminder, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
end
