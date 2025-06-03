class Party < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant, optional: true

  has_many :user_parties
  has_many :users, through: :user_parties

  def members
    result = users.to_a
    result.push(admin)
    result
  end

  def admin
    User.find(user_id)
  end
end
