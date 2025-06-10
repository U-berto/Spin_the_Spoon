class UserPartiesController < ApplicationController

  def index
    @latest_invitation = UserParty
    .where(user: current_user)
    .order(created_at: :desc)
    .first
  end

  def create
    user = User.find(params[:user_id])
    party = Party.find(params[:party_id])

    if UserParty.exists?(user: user, party: party)
      flash[:alert] = "#{user.username} is already invited or part of this party."
    else
      UserParty.create(user: user, party: party, accepted: nil)
      flash[:notice] = "Invitation sent to #{user.username}!"
    end

    redirect_to party_path(party)
  end

  def accept
    user_party = UserParty.find(params[:id])
    user_party.update(accepted: true)
    redirect_to user_parties_path, notice: "You accepted the invitation."
  end

  def decline
    user_party = UserParty.find(params[:id])
    user_party.update(accepted: false)
    redirect_to user_parties_path, alert: "You declined the invitation."
  end
end
