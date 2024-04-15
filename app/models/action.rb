class Action < ApplicationRecord
  belongs_to :user
  belongs_to :challenge_event

  validates :recyclable_weight, presence: true
end
