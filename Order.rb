require './Driver.rb'

class Order
    attr_reader :store, :user, :route, :id, :driver
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
    def add_price(price)
        @price += price
    end
    def delivery_fee
        @route[:to_user] = @user.app.find_path(@store,@user)
        route_count = route[:to_user]
        route_length = route_count.length - 1
        cost = route_length*Driver.price_per_unit
        add_price(cost)
        cost
    end
    def total_price
        @price
    end
    def detail_order
        text = "--------- Order Number #{@id} -----------\n" +
                " From Store #{store.to_s}\n" +
                " Ordered Food\n"
        @thing.each { |i,j|
            text += "     Food #{i.to_s} Amount #{j} Price #{i.price * j}\n"
        }
        text += " Ordered Driver is Driver #{@driver.to_s}\n\n"
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
        reach_store = false
        route.each {|i|
            if(i == @driver.get_location)
                @detail_route += "driver is on the way to store, start at #{i}\n"
                print "driver is on the way to store, start at #{i}\n"
            elsif(i == @store.get_location)
                if(reach_store)
                    @detail_route += "driver has bought the item(s), start at #{i}\n" 
                    print "driver has bought the item(s), start at #{i}\n"
                elsif(!reach_store)
                    @detail_route += "go to #{i}, driver arrived at the store\n"
                    print "go to #{i}, driver arrived at the store\n"
                    reach_store = true
                end
            elsif(i == @user.get_location)
                @detail_route += "go to #{i}, driver arrived at your place\n"
                print "go to #{i}, driver arrived at your place\n"
            else
                @detail_route += "go to #{i}\n"
                print "go to #{i}\n"
            end
            sleep(0.5)    
        }
    end
end