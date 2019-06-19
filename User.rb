require './Human.rb'
require './App.rb'
class User < Human
    def initialize(name)
        super(name)
        @history_order = []
    end
    def give_order(store,*food)
        # driver = @app.
        # @active_order = 
        @history_order.push @active_order

    end
    def run_app(map_size=20,drivers={},store={},user_location=[])
        start_location = user_location.empty? ? [Random.rand(0...map_size),Random.rand(0...map_size)] : user_location
        set_location(start_location[0],start_location[1])
        @app = App.new(map_size,drivers,store,self)
    end
    def app_map
        @app.see_map
    end
    def get_list_store
        list_store = @app.store_list.values
        list_store.each {|i|
            puts "Store #{i.to_s}"
        }
        puts "Closest Store : Store #{@app.get_closest_store(get_location)}"
    end
    def get_list_food(store)
        puts "Store #{store.to_s}"
        store.print_food
    end
end

test = User.new("%")
test.run_app
test.app_map
test.get_list_store