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
end

