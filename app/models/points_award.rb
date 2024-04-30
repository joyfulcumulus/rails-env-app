class PointsAward < ApplicationRecord
  belongs_to :user
  belongs_to :challenge_event
  belongs_to :challenge

  validates :points, presence: true
  validates :points, comparison: { greater_than: 0 }
end
