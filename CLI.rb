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
            puts "Writing History to File"
            @user.write_to_file
            sleep(1)
            puts "Done"
            sleep(0.5)
            @user.file.close
            exit
        elsif (input == 3)
            system("clear")
            see_history
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
            puts "Writing History to File"
            @user.write_to_file
            sleep(1)
            puts "Done"
            sleep(0.5)
            @user.file.close
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
            puts "Writing History to File"
            @user.write_to_file
            sleep(1)
            puts "Done"
            sleep(0.5)
            @user.file.close
            exit
        elsif(0 < input.split(",")[0].to_i && input.split(",")[0].to_i <= store.list_food.length )
            input = input.split(",").collect! {|i| i.to_i}
            state_now[:order][store.get_food(input[0]-1)] = input.length > 1 ? input[1] : 0
            temp_price = 0
            state_now[:order].each {|i,j| 
                temp_price += i.price*j
            }
            state_now[:price] = temp_price
            system("clear")
            show_food(store,state_now)
        elsif(input == "s")
            system("clear")
            confirm_order(state_now)
        else
            system("clear")
            show_food(store,state == nil ? nil : state_now) {puts "No Food or Wrong Command"}
        end
    end
    def confirm_order(state)
        order_processed = @user.give_order(state)
        puts "-------------------Confirm Order---------------------"
        puts "From Store #{state[:store].to_s}"
        state[:order].each {|i,j| 
            puts "Food #{i.to_s} Amount #{j} Price #{j * i.price}"
        }
        puts "Delivery Cost : #{order_processed.delivery_fee}"
        puts "o. Ok"
        puts "b. Back"
        block_given? ? yield : nil
        temp_input = $stdin.gets.chomp
        if(temp_input == "o")
            system("clear")
            process_order(order_processed)
        elsif(temp_input == "b")
            @user.history_order.delete_at(-1)
            system("clear")
            show_food(state[:store],state)
        else
            system("clear")
            confirm_order(state) {puts "Wrong Command"}
        end
    end
    def process_order(order)
        if order.find_driver.nil?
            puts "Looking for driver...."
            driver = @app.generate_single_driver
            sleep(0.8)
            puts "Found Driver, Driver #{driver}"
            sleep(1)
            system("clear")
            process_order(order)
        else
            puts "Processing Order User #{@user.to_s} Number #{@user.active_order.id}"
            puts "Ordered Driver is Driver #{@user.active_order.driver.to_s} - Rating #{@user.active_order.driver.get_rating_value} -- Location #{@user.active_order.driver.get_location}"
            order.follow_route
            sleep(1)
            puts "Order done"
            puts "Give Rating to Driver #{@user.active_order.driver.to_s}"
            sleep(1)
            give_ratings(@user.active_order.driver)
        end
    end
    def give_ratings(driver)
        system("clear")
        puts "Give Rating to Driver #{driver.to_s}"
        puts "Range 1 to 5"
        block_given? ? yield : nil
        input = $stdin.gets.chomp
        if(input.to_i >= 1 && input.to_i <=5 )
            @app.give_driver_rating(driver,input.to_i)
            3.downto(0) { |i|
                puts "Back to menu in #{i}"
                sleep(0.7)
            }
            system("clear")
            main
        else
            give_ratings(driver) {puts "Wrong Input"}
        end
    end
    def see_history
        if @user.history_order.empty?
            puts "No History Order"
        else
            @user.history_order.each {|i|
                puts "#{i.id}. Order id #{i.id} in Store #{i.store.to_s}"
            }
        end
        puts "b. Back"
        puts "e. Exit"
        block_given? ? yield : nil
        input = $stdin.gets.chomp
        if(input == "b")
            system("clear")
            main
        elsif(input == "e")
            system("clear")
            puts "Writing History to File"
            @user.write_to_file
            sleep(1)
            puts "Done"
            sleep(0.5)
            @user.file.close
            exit
        elsif(1<=input.to_i && input.to_i<@user.history_order.length+1)
            system("clear")
            call_history(input.to_i)     
        else
            system("clear")
            see_history {puts "Wrong Command"}
        end
    end
    def call_history(index)
        print @user.history_order[index-1].detail_order
        puts "b. Back"
        puts "e. Exit"
        block_given? ? yield : nil
        input = $stdin.gets.chomp
        if(input == "b")
            system("clear")
            see_history
        elsif(input == "e")
            system("clear")
            puts "Writing History to File"
            @user.write_to_file
            sleep(1)
            puts "Done"
            sleep(0.5)
            @user.file.close
            exit
        else
            system("clear")
            call_history(index) {puts "Wrong Command"}
        end
    end
end