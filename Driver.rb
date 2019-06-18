class Driver
    attr_reader :name, :x, :y
    @@driver_count = 0
    def initialize(name)
        @name = name
        @@driver_count += 1
        @id = @@driver_count
    end
    def set_driver_location(x,y)
        @x = x
        @y = y
    end
    def give_order(order)
        @order = order
    end
    def driver_location
        [@x,@y]
    end
    def to_s
        @name
    end
end