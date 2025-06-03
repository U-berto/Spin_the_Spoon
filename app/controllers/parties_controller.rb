class PartiesController < ApplicationController
  def show
    @hello = "hello frpm controller"
  end
  def create
    category_name = params[:category_name] 
    @party = Party.new(category: category_name, user: current_user)
    
    if @party.save
        redirect_to party_path(@party), notice: "Party created for #{category_name}!"
     else
        flash[:alert] = "Something went wrong"
        redirect_to root_path
    end
  end
end

