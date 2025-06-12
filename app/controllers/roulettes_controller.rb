class RoulettesController < ApplicationController
  def show
    @party = Party.find(params[:party_id])
    address = @party.user.address


    yelp_service = YelpSearchService.new(category: @party.category, address: address, risk_level: @party.risk_level)
    @restaurant = @party.restaurant

    unless @restaurant
      @restaurant = yelp_service.random_restaurant

      @party.update!(restaurant_id: @restaurant.id)
    end
    broadcast_message

    @businesses = Rails.cache.fetch("party_resul\t:#{@party.id}") do
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
