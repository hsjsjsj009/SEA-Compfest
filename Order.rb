class Order
    attr_reader :store, :user, :route, :id, :driver
    @@order_id = 0
    def initialize(user,thing,store,driver,price)
        @user = user
        @thing = thing
        @store = store
        @driver = driver
        @price = price
        @@order_id += 1
        @id = @@order_id
        driver.get_order(self)
        # delivery_fee
    end
    def add_route(route)
        @route = route
    end
    def add_price(price)
        @price += price
    end
    def delivery_fee
        route = {
            to_store:driver.path_to_point(store.get_location),
            to_user:store.path_to_point(user.get_location)
        }
        add_route(route)
        route_length = -2
        route.each{|i,j|
            route_length += j.length
        }
        add_price(route_length*driver.price_per_unit)
    end
    def total_price
        @price
    end
    def detail_order
        text = "--------- Order Number #{@id} -----------\n" +
                " From Store #{store.to_s}\n" +
                " Ordered Food\n"
                
        puts 
        @thing.each { |i,j|
            text += "     Food #{i.to_s} Amount #{j} Price #{i.price * j}\n"
        }
        text += " Ordered Driver is Driver #{@driver.to_s}\n\n"
        text
    end
end