class Spot < ApplicationRecord
  belongs_to :schedule, optional: true

  geocoded_by :address
  after_validation :geocode
end
