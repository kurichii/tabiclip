class Reminder < ApplicationRecord
  belongs_to :list_item, optional: true

  validates :reminder_date, presence: true
end

