class Party < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant, optional: true
  has_many :user_parties
  has_many :users, through: :user_parties

  def members
    accepted_user_parties = []
    user_parties.each do |up|
      accepted_user_parties << up if up.accepted
    end
    result = accepted_user_parties.map(&:user)
    result.push(admin)
    result
  end

  def admin
    User.find(user_id)
  end
end
