class Address < ApplicationRecord
  belongs_to :user
  belongs_to :estate
  belongs_to :location

  validates :street, :zipcode, presence: true
end
