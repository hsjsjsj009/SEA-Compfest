class Order
    attr_reader :store, :user, :route
    def initialize(user,thing,store,driver,price)
        @user = user
        @thing = thing
        @store = store
        @driver = driver
        @price = price
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
end