class RoulettesController < ApplicationController
  def show
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
    end
    broadcast_message

    @businesses = Rails.cache.fetch("party_result:#{@party.id}") do
      yelp_service.options
    end
  end

  def broadcast_message
    Turbo::StreamsChannel.broadcast_append_to "party_#{@party.id}_roulette",
                        partial: "roulettes/redirect",
                        target: "party_zone",
                        locals: { party: @party }
  end

end
