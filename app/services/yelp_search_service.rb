class YelpSearchService
  include HTTParty
  base_uri 'https://api.yelp.com/v3'

  def initialize(category:, address:)
    @category = category
    @address = address
    @headers = {
      "Authorization" => "Bearer #{ENV['YELP_API_KEY']}"
    }
  end

  def random_restaurant
    response = self.class.get("/businesses/search", headers: @headers, query: {
      term: @category,
      location: @address,
      limit: 10
    })

    @businesses = response.parsed_response["businesses"]

    raise "No results from Yelp" if @businesses.blank?

    pick = @businesses.sample

    {
      name: pick["name"],
      location: pick["location"]["address1"],
      rating: pick["rating"]
    }
  end
end
