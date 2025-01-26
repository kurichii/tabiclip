class Spot < ApplicationRecord
  belongs_to :schedule, optional: true
end
