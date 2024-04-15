class Location < ApplicationRecord
  belongs_to :challenge
  has_one :address
end
