class Address < ApplicationRecord
  belongs_to :user
  belongs_to :estate
  has_many :locations

  validates :street, :zipcode, presence: true
end
