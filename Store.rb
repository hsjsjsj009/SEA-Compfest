require './Thing.rb'
class Store
    include Thing
    attr_reader :name
    def initialize(name)
        @name = name
        @list_food = []
    end
    def add_food(food)
        food.each {|i|
            @list_food.push i
        }
    end
    def print_food
        @list_food.length.times {|i|
            puts "#{i+1}. #{@list_food[i].to_s} -- #{@list_food[i].price}"
        }
    end
    def select_food(*index)
        selected_food = []
        price = 0
        index.each {|i|
            select_food.push @list_food[i-1]
            price += @list_food[i-1].price
        }
        { food: select_food, price: price}
    end
end