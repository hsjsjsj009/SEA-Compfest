class Rating
    attr_reader :driver
    def initialize(driver,rating)
        @driver = driver
        @list_rating = [rating]
    end
    def add_rating(rating)
        @list_rating.push rating
    def get_value
        value = 0.0
        @list_rating.each {|i|
            value += i
        }
        value /= @list_rating.length
        value = value.round(1)
        value
    end
end