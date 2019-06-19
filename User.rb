require './Human.rb'
class User < Human
    def initialize(name)
        super(name)
        @history_order = []
    end
    def give_order
        @active_order = 
        @history_order.push @active_order

    end
    def connect_app(app)
        @app = app
    end
end