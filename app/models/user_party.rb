class UserParty < ApplicationRecord
  belongs_to :user
  belongs_to :party
  validates :user_id, uniqueness: { scope: :party_id }
end
