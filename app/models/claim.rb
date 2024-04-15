class Claim < ApplicationRecord
  belongs_to :user
  validates :points, :cdc_voucher_value, presence: true
end
