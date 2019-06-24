require './Thing.rb'
class Store
    include Thing
    attr_reader :name, :list_food, :route_to_user
    def initialize(name)
        @name = name
        @list_food = []
    end
    def add_food(food)
        @list_food.push food
    end
    def connect_app(app)
        @app = app
    end
    def print_food(order_state={})
        if(@list_food.empty?)
            puts "No Food"
        else
            puts "Store #{@name}"
            @list_food.length.times {|i|
                order_count = order_state.empty? ? 0 : order_state[:order][@list_food[i]].to_i
                puts "#{i+1}. #{@list_food[i].to_s} -- #{@list_food[i].price} per unit - count: #{order_count} - price: #{order_count*@list_food[i].price}"
            }
            puts "Total price = #{order_state.empty? ? 0 : order_state[:price]}"
        end
    end
    def select_food(index)
        selected_food = []
        price = 0
        index.each {|i|
            select_food.push @list_food[i-1]
            price += @list_food[i-1].price
        }
        { food: select_food, price: price}
    end
    def get_food(index)
        @list_food[index]
    end
    def to_s
        @name
    end
    def path_to_user(user)
        @route_to_user = @app.find_path(self,user)
        if(@route_to_user == -1)
            -1
        else
            @route_to_user.length - 1
        end
    end
end