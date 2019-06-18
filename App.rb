require './Map.rb'
require './Driver.rb'
class App
    attr_reader :map_size
    def initialize(map_size=20,drivers={},store={})
        @map_size=map_size
        @map = Map.new(map_size)
        @driver_list= drivers.empty? ? generate_random_driver : generate_driver(drivers)
        @map.generate_map
    end
    def generate_random_driver
        driver = {}
        ('a'..'e').to_a.each { |i|
            driver[i.to_sym] = Driver.new(i)
            loc = generate_random_loc
            driver[i.to_sym].set_driver_location(loc[0],loc[1])
            @map.add_thing(driver[i.to_sym], driver[i.to_sym].driver_location)
        }
        driver
    end
    def generate_driver(dict)
        driver = {}
        dict.each {|i,j| 
            driver[i.to_sym] = Driver.new(i)
            driver[i.to_sym].set_driver_location(j[0],j[1])
        }
        driver
    end
    def generate_random_loc
        list_coordinates = @map.list_thing.values
        find_state = false
        while !find_state
            rand_location = [Random.rand(0...size),Random.rand(0...size)]
            if !list_coordinates.contains?(rand_location)
                if (
                    !list_coordinates.contains?([rand_location[0]-1,rand_location[1]]) &&
                    !list_coordinates.contains?([rand_location[0]-1,rand_location[1]-1]) &&
                    !list_coordinates.contains?([rand_location[0],rand_location[1]-1]) &&
                    !list_coordinates.contains?([rand_location[0]+1,rand_location[1]-1]) &&
                    !list_coordinates.contains?([rand_location[0]+1,rand_location[1]]) &&
                    !list_coordinates.contains?([rand_location[0]+1,rand_location[1]+1]) &&
                    !list_coordinates.contains?([rand_location[0],rand_location[1]+1]) &&
                    !list_coordinates.contains?([rand_location[0]-1,rand_location[1]+1])
                    )
                find_state = true
                end
            end
        end
        rand_location
    end
end
