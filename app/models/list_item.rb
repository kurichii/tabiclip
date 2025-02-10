class ListItem < ApplicationRecord
  belongs_to :check_list

  validates :title, presence: true, length: { maximum: 255 }
end
