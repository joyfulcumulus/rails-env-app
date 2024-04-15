class RewardsProgramme < ApplicationRecord
  belongs_to :challenge

  validates :target, :unit_of_measurement, :points, presence: true
end
