class Human
    attr_reader :name, :x, :y
    def initialize(name)
        @name = name
    end
    def set_location(x,y)
        @x = x
        @y = y
    end
    def get_location
        [@x,@y]
    end
    def to_s
        @name
    end
end