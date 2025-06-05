class YelpSearchService
  include HTTParty
  base_uri 'https://api.yelp.com/v3'

  def initialize(category:, address:, risk_level:)
    @category = category
    @address = address
    @risk_level = risk_level
    @headers = {
      "Authorization" => "Bearer #{ENV['YELP_API_KEY']}"
    }

    response = self.class.get("/businesses/search", headers: @headers, query: {
      term: "restaurant",
      categories: @category,
      location: @address,
      limit: 10
    })
    responses = response.parsed_response["businesses"]
    @businesses = []
    responses.each do |response|
      instantiate_restaurant_from_yelp(response)
      @businesses << response
    end
  end

  def options
    return @businesses if risk_level == "2"

    response = self.class.get("/businesses/search", headers: @headers, query: {
      term: "restaurant",
      categories: @category,
      location: @address,
      limit: 5
    })
    businesses = response.parsed_response["businesses"]
    choices = []
    businesses.each do |choice|
      instantiate_restaurant_from_yelp(choice)
      choices << choice
    end
    restaurants = Restaurant.where(category: @category).where("rating <= 3")
    choices + restaurants
  end

  def random_restaurant
    raise "No results from Yelp" if @businesses.blank?

    @businesses.sample
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
