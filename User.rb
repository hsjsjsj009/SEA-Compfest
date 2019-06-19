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
end

test = User.new("%")
test.run_app
test.app_map
