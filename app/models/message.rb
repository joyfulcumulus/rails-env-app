class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user

  validates :content, length: { minimum: 1, too_short: "needs at least 1 character" }
end
