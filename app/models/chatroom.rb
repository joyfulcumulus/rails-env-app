class Chatroom < ApplicationRecord
  belongs_to :challenge
  belongs_to :estate
  has_many :messages, dependent: :destroy
  has_many :chatroom_members, dependent: :destroy
  has_many :users, through: :chatroom_members
end
