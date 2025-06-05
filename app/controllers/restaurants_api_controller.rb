class RestaurantsApiController < ApplicationController
  def pick_restaurant
    party = Party.find(params[:id])
    user = party.admin
    category = party.category
    address = user.address

    begin
      yelp_data = YelpSearchService.new(category: category, address: address).random_restaurant

      restaurant = Restaurant.create!(
        name: yelp_data[:name],
        location: yelp_data[:location],
        category: category,
        rating: yelp_data[:rating],
        latitude: yelp_data[:latitude],
        longitude: yelp_data[:longitude],
        image: yelp_data[:image]
      )

      party.update!(restaurant_id: restaurant.id)

      redirect_to restaurant_path(restaurant), notice: "Restaurant selected!"
    rescue => e
      logger.error "Yelp search failed: #{e.message}"
      redirect_back fallback_location: root_path, alert: "Could not find a restaurant."
    end
  end
end
