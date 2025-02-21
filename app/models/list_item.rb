class ListItem < ApplicationRecord
  belongs_to :check_list, foreign_key: :check_list_uuid

  validates :title, presence: true, length: { maximum: 255 }
end
