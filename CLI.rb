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
        elsif(0 < input.to_i && input.to_i <= @app.store_list.values.length)
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
        store.print_food(state != nil ? state_now : {})
        puts "s. Submit"
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
        elsif(0 < input.split(",")[0].to_i && input.split(",")[0].to_i <= store.list_food.length )
            input = input.split(",").collect! {|i| i.to_i}
            state_now[:order][store.get_food(input[0]-1)] = input.length > 1 ? input[1] : 0
            state_now[:price] += store.get_food(input[0]-1).price * (input.length > 1 ? input[1] : 0)
            system("clear")
            show_food(store,state_now)
        elsif(input == "s")
            system("clear")
            confirm_order(state_now)
        else
            system("clear")
            show_food(store,state == nil ? nil : state_now) {puts "No Food"}
        end
    end
    def confirm_order(state)
        puts "-------------------Confirm Order---------------------"
        puts "From Store #{state[:store].to_s}"
        state[:order].each {|i,j| 
            puts "Food #{i.to_s} Amount #{j} Price #{j * i.price}"
        }
        puts "o. Ok"
        puts "b. Back"
        block_given? ? yield : nil
        temp_input = $stdin.gets.chomp
        if(temp_input == "o")
            system("clear")
            process_order(state)
        elsif(temp_input == "b")
            system("clear")
            show_food(state[:store],state)
        else
            system("clear")
            confirm_order(state) {puts "Wrong Command"}
        end
    end
    def process_order(state)
        puts "Processing Order Number #{@user.history_order.length + 1}"
        @user.give_order(state)
    
    end
end