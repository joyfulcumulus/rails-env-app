class ChallengeEvent < ApplicationRecord
  belongs_to :challenge

  validates :start_datetime, :end_datetime, presence: true
end
