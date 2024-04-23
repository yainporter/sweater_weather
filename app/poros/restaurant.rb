class Restaurant
  attr_reader :name, :address, :rating, :reviews

  def initialize(restaurant_data)
    restaurant_data = restaurant_data[:businesses].first
    @name = restaurant_data[:name]
    @address = restaurant_data[:location][:display_address].join(", ")
    @rating = restaurant_data[:rating]
    @reviews = restaurant_data[:review_count]
  end
end
