class Challenge < ApplicationRecord
  has_one_attached :cover
  has_many :participations
  has_many :users, through: :participations

  validates :name, :description, :participant_criteria, :start_date, :end_date, presence: true
end
