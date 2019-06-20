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
        input = $stdin.gets.chomp.to_i
        if(input == 1)
            system("clear")
            @user.app_map
            main
        elsif (input == 2)
            system("clear")
            order_menu
        elsif (input == 4)
            exit
        end
    end
    def order_menu
        @user.app_map
        @user.get_list_store
        puts "b. Back"
        puts "e. Exit"
        input = $stdin.gets.chomp
        
    end

end