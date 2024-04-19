class TotalPoint < ApplicationRecord
  belongs_to :user

  validates :total_points, presence: true
end
