class Party < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  # has_many :user_parties
  # has_many :users, through: :user_parties


end
