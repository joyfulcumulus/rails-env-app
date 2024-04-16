class Location < ApplicationRecord
  belongs_to :challenge
  belongs_to :address
end
