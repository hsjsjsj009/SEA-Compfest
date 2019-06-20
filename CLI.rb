class CLI
    def initialize(user,app)
        @user = user
        @app = app
        system("clear")
        main
    end
    def main
        puts "----------------Welcome, to Go-Eat--------------------"
        puts "1. Show Map"
        puts "2. Order Food"
        puts "3. Show History"
        puts "4. Exit"
        block_given? ? yield : nil
        input = $stdin.gets.chomp.to_i
        if(input == 1)
            system("clear")
            @user.app_map
            main
        elsif (input == 2)
            system("clear")
            order_menu
        elsif (input == 4)
            system("clear")
            exit
        else 
            system("clear")
            main {puts "Wrong Command"}
        end
    end
    def order_menu
        @user.get_list_store
        puts "b. Back"
        puts "e. Exit"
        block_given? ? yield : nil
        input = $stdin.gets.chomp
        if(input == "b")
            system("clear")
            main
        elsif(input == "e")
            system("clear")
            exit
        elsif(input.to_i =< )
            system("clear")
            show_food(@app.store_list.values[input.to_i-1])
        end
    end
    def show_food(store,state = nil)
        state_now = state == nil ? {
            store:store,
            order:{},
            price:0
        }
        : state
        store.print_food(state != nil ? state : {})
        puts "b. Back"
        puts "e. Exit"
        puts "To order type food_code,ammount ex:2,5"
        block_given? ? yield : nil
        input = $stdin.gets.chomp
        if(input == "b")
            system("clear")
            order_menu
        elsif(input == "e")
            system("clear")
            exit
        elsif(input.split(",")[0].to_i <= store.list_food.length)
            input = input.split(",").collect! {|i| i.to_i}
            state_now[:order][store.get_food(input[0]-1)] = input.length > 1 ? input[1] : 0
            state_now[:price] += store.get_food(input[0]-1).price * (input.length > 1 ? input[1] : 0)
            system("clear")
            show_food(store,state_now)
        else
            system("clear")
            show_food(store,state == nil ? nil : state_now) {puts "No Food"}
        end
    end


end