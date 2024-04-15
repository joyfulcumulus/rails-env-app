class Address < ApplicationRecord
  belongs_to :estate

  validates :street, :zipcode, presence: true
end
