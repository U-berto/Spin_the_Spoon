class User < ApplicationRecord
  has_many :user_parties
  has_many :parties, through: :user_parties
  has_many :admin_parties, class_name: "Party"
  has_many :friendships
  has_many :friends, through: :friendships
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def friend(other_user)
    Friendship.create(user: self, friend: other_user)
    Friendship.create(user: other_user, friend: self)
  end
end
