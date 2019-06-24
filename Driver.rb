require './Human.rb'
require './Rating.rb'
class Driver < Human
    attr_reader :id, :active_order
    attr_accessor :price_per_unit
    @@driver_count = 0
    @@price_per_unit = 300
    def initialize(name,rating=0.0)
        super(name)
        @@driver_count += 1
        @id = @@driver_count
        @history_order = []
        @price_per_unit = @@price_per_unit
        @rating = Rating.new(self,rating)
    end
    def self.price_per_unit
        @@price_per_unit
    end
    def do_order(order)
        @active_order = order
        @history_order.push order
    end
    def add_rating(rating)
        @rating.add_rating(rating.to_f)
    end
    def get_rating_value
        @rating.get_value
    end
    def connect_app(app)
        @app = app
    end
end