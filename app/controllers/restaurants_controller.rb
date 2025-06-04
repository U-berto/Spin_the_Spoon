class RestaurantsController < ApplicationController

  def show
    @restaurant = Restaurant.find(params[:id])
    @markers = [
    { lat: @restaurant.latitude, lng: @restaurant.longitude }
  ]
  end

end
