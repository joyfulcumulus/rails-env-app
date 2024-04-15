class Chatroom < ApplicationRecord
  belongs_to :challenge
  belongs_to :estate
  has_many :messages
end
