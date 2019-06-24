require './Map.rb'
require './Driver.rb'
require './Store.rb'
require './Food.rb'

class App
    attr_reader :map_size, :store_list, :driver_list, :map
    def initialize(map_size,drivers,store,user)
        @map_size=map_size
        @map = Map.new(map_size)
        @user = user
        @map.add_thing({ @user => @user.get_location })
        @location_used = [@user.get_location]
        @driver_list= drivers.empty? ? generate_random_driver : generate_driver(drivers)
        @store_list = store.empty? ? generate_default_store : generate_store(store)
        @map.connect_node
    end
    def generate_default_store
        store = {}
        ('1'..'3').each { |i|
            temp_store = Store.new(i)
            temp_store.connect_app(self)
            store[i.to_sym] = temp_store
            price_start = 100
            ((i+'A')..(i+'C')).each { |j|
                temp_store.add_food(Food.new(j,price_start))
                price_start += 100
            }
            location = generate_random_loc
            temp_store.set_location(location[0],location[1])
            @map.add_thing({temp_store => temp_store.get_location})
            @location_used.push location
        }
        store
    end
    def generate_store(dict)
        store = {}
        dict.each {|i,j|
            loc = j[:location]
            food = j[:food]
            temp_store = Store.new(i)
            temp_store.connect_app(self)
            store[i.to_sym] = temp_store
            food.each {|k,l| 
                temp_store.add_food(Food.new(k,l))
            }
            temp_store.set_location(loc[0],loc[1])
            @map.add_thing({temp_store => temp_store.get_location})
            @location_used.push loc
        }
        store
    end
    def generate_random_driver
        driver = {}
        ('a'..'e').to_a.each { |i|
            driver[i.to_sym] = Driver.new(i)
            driver[i.to_sym].connect_app(self)
            loc = generate_random_loc
            driver[i.to_sym].set_location(loc[0],loc[1])
            @map.add_thing({driver[i.to_sym] => driver[i.to_sym].get_location })
            @location_used.push loc
        }
        driver
    end
    def generate_single_driver
        found = false
        while !found
            driver_name = ("aa".."zz").to_a.sample
            if(!@driver_list.keys.include?(driver_name.to_sym))
                @driver_list[driver_name.to_sym] = Driver.new(driver_name)
                @driver_list[driver_name.to_sym].connect_app(self)
                loc = generate_random_loc
                @driver_list[driver_name.to_sym].set_location(loc[0],loc[1])
                @map.add_thing({@driver_list[driver_name.to_sym] => loc})
                found = true
                @location_used.push loc
            end
        end
        driver_name
    end
    def generate_driver(dict)
        driver = {}
        dict.each {|i,j|
            loc = j[:location]
            rating = j[:rating].nil? ? 0 : j[:rating]
            driver[i.to_sym] = Driver.new(i,rating)
            driver[i.to_sym].connect_app(self)
            driver[i.to_sym].set_location(loc[0],loc[1])
            @map.add_thing({driver[i.to_sym] => driver[i.to_sym].get_location})
            @location_used.push loc
        }
        driver
    end
    def generate_random_loc
        while true
            x = (0...@map_size).to_a.sample
            y = (0...@map_size).to_a.sample
            rand_location = [x,y]
            if (@location_used.include?(rand_location))
                next
            else
                if(@map.check_area(rand_location))
                    break
                else
                    next
                end
            end
        end
        rand_location
    end
    def see_map
        @map.print_map
    end
    def get_closest_driver(coordinates)
        if(@driver_list.values.length == 0)
            nil
        else
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
    def get_thing(coordinates)
        @map.get_thing(coordinates)
    end
    def give_driver_rating(driver,rating)
        driver.add_rating(rating)
        rating_value = driver.get_rating_value
        if(rating_value < 3.0)
            remove_thing(driver,driver.get_location)
            @driver_list.delete(driver.to_sym)
        end
    end
    def move_thing(thing,location)
        @map.move_thing({thing => location})
    end
    def remove_thing(thing,location)
        @map.remove_thing({thing => location})
    end
    def find_path(start,finish)
        start_loc = start.get_location
        finish_loc = finish.get_location
        start_thing = @map.get_thing(start_loc)
        finish_thing = @map.get_thing(finish_loc)
        @map.path_to_point(start_thing,finish_thing)      
    end
end

# test = App.new(5, {}, {})
# test.see_map
# print "#{test.find_path(test.driver_list.values[0],test.store_list.values[1])}\n\n"
# test.see_map
# # print "#{test.map.list_thing}"