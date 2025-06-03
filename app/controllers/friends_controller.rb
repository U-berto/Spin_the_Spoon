class FriendsController < ApplicationController

  def index
    @friendships = current_user.friends
  end

  def create
    @friend = 
  # when adding a friend we will create a new friendship and current_user.friend(other_user)
  end
end
