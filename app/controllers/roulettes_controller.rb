class RoulettesController < ApplicationController
  def show
    # if party has a restaurant id skip the show method
    # remove the spin the spoon button on show of roulettes

    @party = Party.find(params[:party_id])
    address = @party.user.address


    yelp_service = YelpSearchService.new(category: @party.category, address: address, risk_level: @party.risk_level)
    @restaurant = @party.restaurant

    unless @restaurant
      picked_restaurant = yelp_service.random_restaurant
      picked_restaurant.save

      @restaurant = Restaurant.create!(
        name: picked_restaurant[:name],
        location: picked_restaurant[:location],
        category: @party.category,
        rating: picked_restaurant[:rating],
        latitude: picked_restaurant[:latitude],
        longitude: picked_restaurant[:longitude],
        image: picked_restaurant[:image]
      )

      @party.update!(restaurant_id: @restaurant.id)
      # broadcast a message to channel saying that you have result --> redirect to show roulettes
    end

    @businesses = Rails.cache.fetch("party_result:#{@party.id}") do
      yelp_service.options
    end
  end
  # def pick_restaurant
  #   party = Party.find(params[:id])
  #   user = party.admin
  #   category = party.category
  #

  #   begin

  #     redirect_to restaurant_path(restaurant), notice: "Restaurant selected!"
  #   rescue => e
  #     logger.error "Yelp search failed: #{e.message}"
  #     redirect_back fallback_location: root_path, alert: "Could not find a restaurant."
  #   end
  # end
end
