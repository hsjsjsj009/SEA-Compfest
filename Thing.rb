module Thing
    attr_reader :x,:y
    def set_location(x,y)
        @x = x
        @y = y
    end
    def get_location
        [@x,@y]
    end
    def distance_to_point(coordinates)
        value = (((@x - coordinates[0])**2) + 
        ((@y - coordinates[1])**2)) ** 0.5
        value
    end          
end