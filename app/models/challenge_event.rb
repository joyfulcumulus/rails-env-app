class ChallengeEvent < ApplicationRecord
  belongs_to :challenge
  has_many :actions, dependent: :destroy
  has_many :users, through: :actions

  validates :start_datetime, :end_datetime, presence: true
end
