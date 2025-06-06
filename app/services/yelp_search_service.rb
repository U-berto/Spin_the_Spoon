class YelpSearchService
  include HTTParty
  base_uri 'https://api.yelp.com/v3'

  def initialize(category:, address:, risk_level:)
    @category = category == "Discover local" ? "tapas" : category
    @address = address
    @risk_level = risk_level
    @headers = {
      "Authorization" => "Bearer #{ENV['YELP_API_KEY']}"
    }
  end

  def options
    return @options if @options.present?

    response = self.class.get("/businesses/search", headers: @headers, query: {
      term: @category,
      categories: "restaurants",
      location: @address,
      limit: 20
    })

    businesses = response.parsed_response["businesses"].sample(@risk_level == "1" ? 10 : 5)


    choices = []
    businesses.each do |choice|
      choices << instantiate_restaurant_from_yelp(choice)
    end


    restaurants = Restaurant.where(category: @category).where("rating <= 3").limit(10 - businesses.length)
    @options = choices + restaurants

    @options
  end

  def random_restaurant
    options.sample
  end

  def instantiate_restaurant_from_yelp(yelp_data)
    Restaurant.new({
      name: yelp_data["name"],
      location: yelp_data["location"]["address1"],
      rating: yelp_data["rating"],
      category: @category,
      latitude: yelp_data["coordinates"]["latitude"],
      longitude: yelp_data["coordinates"]["longitude"],
      image: yelp_data["image_url"]
    })
  end
end
