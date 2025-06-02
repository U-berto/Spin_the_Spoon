class User < ApplicationRecord
  # has_one :party
  # belongs_to :party, through: :user_parties
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # def generate_party
  # UserParty.create!(user: self)
  # end
end
