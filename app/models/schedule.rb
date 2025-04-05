class Schedule < ApplicationRecord
  belongs_to :travel_book
  has_one :spot, dependent: :destroy
  belongs_to :schedule_icon, optional: true

  def self.group_by_date(schedules)
    schedules.group_by { |schedule| (schedule.start_date&.to_date || schedule.end_date&.to_date) || "日付未定" }
  end
end
