class Challenge < ApplicationRecord
  has_one_attached :cover
  has_many :participations, dependent: :destroy
  has_many :users, through: :participations
  has_many :challenge_events, dependent: :destroy
  has_many :rewards_programmes, dependent: :destroy
  has_many :locations, dependent: :destroy
  has_many :chatrooms, dependent: :destroy
  has_many :addresses, through: :locations
  has_many :points_awards, through: :challenge_events

  # accepts_nested_attributes_for :rewards_programmes

  OBJECTIVES = %w[maximize minimize]
  validates :metric_objective, inclusion: { in: OBJECTIVES }
  validates :name, :description, :participant_criteria, :start_date, :end_date, :metric_name, :metric_unit, presence: true
end
