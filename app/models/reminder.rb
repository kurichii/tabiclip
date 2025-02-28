class Reminder < ApplicationRecord
  belongs_to :list_item, optional: true

  validates :reminder_date, presence: true
  validate :reminder_date_cannot_be_in_the_past

  def reminder_date_cannot_be_in_the_past
    if reminder_date.present? && reminder_date < Time.zone.now
      errors.add(:reminder_date, :reminder_date_cannot_be_in_the_past)
    end
  end
end
