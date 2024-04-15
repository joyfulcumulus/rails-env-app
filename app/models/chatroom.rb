class Chatroom < ApplicationRecord
  belongs_to :challenge
  belongs_to :estate
  has_many :messages
  has_many :chatroom_members
  has_many :users, through: :chatroom_members
end
