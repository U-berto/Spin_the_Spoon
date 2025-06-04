class PartiesController < ApplicationController
  include ApplicationHelper

  def create
    user_input = params[:category_name].strip.capitalize # Get user input
    matched_cuisine = find_cuisine(user_input) # Try to match input

    if matched_cuisine && CUISINES.include?(matched_cuisine) # Ensure the match is valid
      @party = Party.new(category: matched_cuisine, user: current_user)
      if @party.save
        redirect_to pick_restaurant_path(@party), notice: "Party created for #{matched_cuisine}!"
      else

        flash[:alert] = "Something went wrong"
        redirect_to root_path
      end
    else
      flash[:alert] = "Cuisine not found. Please write a valid option."
      redirect_to root_path
    end
  end

  def show
    @party = Party.find(params[:id])
    # encryptor = ActiveSupport::MessageEncryptor.new(ENV["RAILS_MASTER_KEY"], cipher: "aes-256-gcm"
    @pin = @party.id
  end

  def join
    @party = Party.find(params[:pin])
    @user_1 = current_user
      if @party.members.include?(current_user)
        redirect_to party_path(@party)
        flash[:alert] = "Already part of this party"
      else
      @invite = UserParty.create(user: @user_1, party: @party, accepted:true)
      redirect_to party_path(@party)
    end
  end
end
