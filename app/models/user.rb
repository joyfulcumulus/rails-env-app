class User < ApplicationRecord
  has_one_attached :avatar
  has_many :participations, dependent: :destroy
  has_many :challenges, through: :participations
  has_many :claims, dependent: :destroy
  has_many :actions, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :chatroom_members, dependent: :destroy
  has_many :chatrooms, through: :chatroom_members
  belongs_to :address

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :email, :password, presence: true
  validates :email, uniqueness: true
end
