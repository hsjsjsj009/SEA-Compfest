class FileParser
    def initialize(filename)
        @file = open(filename,"r")
        @data = {user:{},driver:{}}
        @read_line = 0
    end
    def read_file(file)
        file.each_line{|i|
            @read_line += 1
            if(i == "Map")
                map(file)
            elsif (i == "User")
                user(file)
            elsif(i == "\n")
                next
            else
                puts "Incorrect command line #{@read_line}"
                break
            end
        }
        @file.close
    end
    def map(file)
        correct = true
        file.each_line{|i|
            @read_line += 1
            if(i == "end")
                break
            elsif(i.include? "map_size")
                i = i.split("=")
                begin
                    @data[:map_size]=eval i[1]
                rescue
                    puts "Incorrect command line #{@read_line}"
                    correct = false
                    break
                end
            elsif(i == "\n")
                next    
            else
                puts "Incorrect command line #{@read_line}"
                correct = false
                break
            end
        }
        if(correct)
            read_file(file)
        else
            @file.close
        end
    end
    def user(file)
        correct = true
        file.each_line{|i|
            @read_line += 1
            if(i == "end")
                break
            elsif(i.include? "name")
                begin
                    i = i.split("=")
                    @data[:user][:name] = i[1]
                rescue
                    puts "Incorrect command line #{@read_line}"
                    correct = false
                    break
                end
            elsif(i.include? "location")
                begin
                    i = i.split("=")
                    loc = i[1].split(",").collect! {|i| eval i}
                    @data[:user][:location] = loc
                rescue
                    puts "Incorrect command line #{@read_line}"
                    correct = false
                    break
                end
            elsif(i == "\n")
                next
            else
                puts "Incorrect command line #{@read_line}"
                correct = false
                break
            end
        }
        if(correct)
            read_file(file)
        else
            @file.close
        end
    end
    def driver(file)
        correct = true
        state = nil
        file.each_line {|i|
            @read_line += 1
            if(i == "end")
                break
            end
        }
    end
end