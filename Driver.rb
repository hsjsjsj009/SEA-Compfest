require './Human.rb'
class Driver < Human
    @@driver_count = 0
    def initialize(name)
        super(name)
        @@driver_count += 1
        @id = @@driver_count
    end
    def give_order(order)
        @order = order
    end
end