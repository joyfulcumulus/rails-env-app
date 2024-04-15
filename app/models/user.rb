class User < ApplicationRecord
  has_one_attached :avatar
  has_many :participations
  has_many :challenges, through: :participations
  has_many :claims
  has_many :actions
  has_many :messages
  has_many :chatroom_members
  has_many :chatrooms, through: :chatroom_members

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :email, :password, presence: true
  validates :email, uniqueness: true
end
