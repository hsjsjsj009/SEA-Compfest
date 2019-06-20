require './Human.rb'
require './App.rb'
require './Order.rb'
require './CLI.rb'

class User < Human
    attr_reader :app
    def initialize(name)
        super(name)
        @history_order = []
    end
    def give_order(store,food)
        driver = @app.get_closest_driver(store.get_location)
        @active_order = Order.new(self,food,store,driver)
        @history_order.push @active_order
    end
    def run_app(map_size=20,drivers={},store={},user_location=[])
        start_location = user_location.empty? ? [Random.rand(0...map_size),Random.rand(0...map_size)] : user_location
        set_location(start_location[0],start_location[1])
        @app = App.new(map_size,drivers,store,self)
        @cli = CLI.new(self,@app)
    end
    def app_map
        @app.see_map
        puts "User is %"
    end
    def get_list_store
        list_store = @app.store_list.values
        list_store.length.times {|i|
            puts "#{i+1}. Store #{list_store[i].to_s}"
        }
        puts "Closest Store : Store #{@app.get_closest_store(get_location)}"
    end
end

test = User.new("%")
test.run_app()