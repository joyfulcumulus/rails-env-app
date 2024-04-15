class Challenge < ApplicationRecord
  has_one_attached :cover

  validates :name, :description, :participant_criteria, :start_date, :end_date, presence: true
end
