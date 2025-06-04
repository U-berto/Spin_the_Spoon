class PartiesController < ApplicationController
  include ApplicationHelper

  def create
    user_input = params[:category_name].strip.capitalize  
    matched_cuisine = find_cuisine(user_input) 

    if matched_cuisine && CUISINES.include?(matched_cuisine) 
      @party = Party.new(category: matched_cuisine, user: current_user) #add the risk-level in the creation of the party
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

