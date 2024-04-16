class Address < ApplicationRecord
  belongs_to :estate
  has_many :locations
  has_many :users

  validates :street, :zipcode, presence: true
end
