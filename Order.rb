require './Driver.rb'

class Order
    attr_reader :store, :user, :route, :id, :driver, :price
    @@order_id = 0
    def initialize(user,thing,store,price)
        @user = user
        @thing = thing
        @store = store
        @driver = nil
        @price = price
        @@order_id += 1
        @id = @@order_id
        @route = {}
        @detail_route = ""
    end
    def add_driver_route(route)
        @route[:to_store] = route
    end
    def set_price(price)
        @price = price
        @price
    end
    def delivery_fee
        route = @store.route_to_user
        route_length = route.length - 1
        cost = route_length*Driver.price_per_unit
        @delivery_cost = cost
        @delivery_length = route_length
        {cost:cost,length:route_length}
    end
    def total_price
        @price
    end
    def detail_order
        text = "--------- Order Number #{@id} -----------\n" +
                "User #{@user.to_s} -- location #{@user.get_location}\n" +
                " From Store #{@store.to_s} -- location #{@store.get_location}\n" +
                " Ordered Food\n"
        @thing.each { |i,j|
            text += "     Food #{i.to_s} Amount #{j} Price #{i.price * j}\n"
        }
        text += " Delivery Cost = #{@delivery_cost} -- #{@delivery_length} units\n"
        text += " Total Price = #{@price}\n"
        text += " Ordered Driver is Driver #{@driver.to_s}\n\n"
        text += "Route :\n" + @detail_route +"\n"
        text
    end
    def find_driver
        @driver = @user.app.get_closest_driver(@store.get_location)
        if !@driver.nil?
            @route[:to_store] = @user.app.find_path(@driver,@store)
            @driver.do_order(self)
        end
        @driver
    end
    def follow_route
        route = @route[:to_store] + @route[:to_user]
        start = false
        reach_store = false
        counter = 0
        route.each {|i|
            if(i == @driver.get_location && !start)
                @detail_route += "driver is on the way to store, start at #{i}\n"
                print "driver is on the way to store, start at #{i}\n"
                start = true
            elsif(i == @store.get_location)
                if(reach_store)
                    @detail_route += "driver has bought the item(s), start at #{i}\n" 
                    print "driver has bought the item(s), start at #{i}\n"
                elsif(!reach_store)
                    @detail_route += "go to #{i}, driver arrived at the store\n"
                    print "go to #{i}, driver arrived at the store\n"
                    reach_store = true
                    sleep(0.8)
                end
            elsif(i == @user.get_location && counter == route.length-1)
                @detail_route += "go to #{i}, driver arrived at your place\n"
                print "go to #{i}, driver arrived at your place\n"
            else
                @detail_route += "go to #{i}\n"
                print "go to #{i}\n"
            end
            counter += 1
            sleep(0.5)    
        }
        rand_location = @user.app.generate_random_loc
        @user.app.move_thing(@driver,rand_location)
    end
end