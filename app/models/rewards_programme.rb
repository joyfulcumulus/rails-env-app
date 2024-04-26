class RewardsProgramme < ApplicationRecord
  belongs_to :challenge

  validates :target, :points, presence: true
end
