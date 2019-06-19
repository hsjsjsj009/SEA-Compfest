module Thing
    attr_reader :x,:y
    def set_location(x,y)
        @x = x
        @y = y
    end
    def get_location
        [@x,@y]
    end
end