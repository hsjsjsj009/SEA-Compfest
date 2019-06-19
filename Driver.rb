require './Human.rb'
class Driver < Human
    attr_reader :id, :active_order
    attr_accessor :price_per_unit
    @@driver_count = 0
    @@price_per_unit = 300
    def initialize(name)
        super(name)
        @@driver_count += 1
        @id = @@driver_count
        @history_order = []
        @price_per_unit = @@price_per_unit
    end
    def get_order(order)
        @active_order = order
        @history_order.push order
    end
    def distance_to_point(coordinates)
        value = (((@x - coordinates[0])**2) + 
        ((@y - coordinates[1])**2)) ** 0.5
        value
    end
end