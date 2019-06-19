require './Map.rb'
require './Driver.rb'
require './Store.rb'
require './Food.rb'

class App
    attr_reader :map_size, :store_list, :driver_list
    def initialize(map_size,drivers,store,user)
        @map_size=map_size
        @map = Map.new(map_size)
        @user = user
        @map.add_thing({ @user => @user.get_location })
        @store_list = store.empty? ? generate_default_store : generate_store(store)
        @driver_list= drivers.empty? ? generate_random_driver : generate_driver(drivers)
    end
    def generate_default_store
        store = {}
        ('1'..'3').each { |i|
            temp_store = Store.new(i)
            store[i.to_sym] = temp_store
            price_start = 100
            ((i+'A')..(i+'C')).each { |j|
                temp_store.add_food(Food.new(j,price_start))
                price_start += 100
            }
            location = generate_random_loc
            temp_store.set_location(location[0],location[1])
            @map.add_thing({temp_store => temp_store.get_location})
        }
        store
    end
    def generate_random_driver
        driver = {}
        ('a'..'e').to_a.each { |i|
            driver[i.to_sym] = Driver.new(i)
            loc = generate_random_loc
            driver[i.to_sym].set_location(loc[0],loc[1])
            @map.add_thing({driver[i.to_sym] => driver[i.to_sym].get_location })
        }
        driver
    end
    def generate_driver(dict)
        driver = {}
        dict.each {|i,j| 
            driver[i.to_sym] = Driver.new(i)
            driver[i.to_sym].set_location(j[0],j[1])
            @map.add_thing(driver[i.to_sym], driver[i.to_sym].get_location)
        }
        driver
    end
    def generate_random_loc
        list_coordinates = @map.list_thing.values
        find_state = false
        while !find_state
            rand_location = [Random.rand(0...@map_size),Random.rand(0...@map_size)]
            if !list_coordinates.include?(rand_location)
                if(@map.check_area(rand_location))
                    find_state=true
                end
            end
        end
        rand_location
    end
    def see_map
        @map.print_map
    end
    def get_closest_driver(coordinates)
        first, *last = @driver_list.values 
        closest_driver = first
        closest_distance = first.distance_to_point(coordinates)
        last.each { |i|
            substract = i.distance_to_point(coordinates)
            if(substract<closest_distance)
                closest_driver = i
                closest_distance = substract
            end
        }
        closest_driver
    end
    def get_closest_store(coordinates)
        first, *last = @store_list.values 
        closest_store = first
        closest_distance = first.distance_to_point(coordinates)
        last.each { |i|
            substract = i.distance_to_point(coordinates)
            if(substract<closest_distance)
                closest_store = i
                closest_distance = substract
            end
        }
        closest_store
    end
end