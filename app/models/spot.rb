class Spot < ApplicationRecord
  belongs_to :schedule, optional: true, primary_key: :uuid, foreign_key: :schedule_uuid

  geocoded_by :address
  after_validation :geocode
end
