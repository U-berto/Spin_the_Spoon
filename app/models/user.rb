class User < ApplicationRecord
  has_many :user_parties
  has_many :parties, through: :user_parties
  has_many :admin_parties, class_name: "Party"
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def friend(other_user)
    Friendship.create(user: self, friend: other_user)
    Friendship.create(user: other_user, friend: self)
  end
end
