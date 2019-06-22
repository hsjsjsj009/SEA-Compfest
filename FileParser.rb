class FileParser
    attr_reader :data
    def initialize(filename)
        @file = open(filename,"r")
        @data = {user:{},driver:{},store:{}}
        @read_line = 0
    end
    def close
        @file.close
    end
    def read_file(file = @file)
            correct = true
            file.each_line{|i|
                i = i.chomp("\n")
                @read_line += 1
                if(i == "Map")
                    if(map(file) == "error")
                        correct = false
                        break
                    end
                elsif (i == "User")
                    if(user(file) == "error")
                        correct = false
                        break
                    end 
                elsif (i == "Driver")
                    if(driver(file) == "error")
                        correct = false
                        break
                    end
                elsif(i == "")
                    next
                else
                    puts "Incorrect command line #{@read_line}"
                    correct = false
                    break
                end
            }
            if(correct)
                nil
            else
                "error"
            end
            
    end
    def map(file)
        correct = true
        map_size = false
        file.each_line{|i|
            i = i.chomp("\n")
            @read_line += 1
            if(i == "end")
                if(map_size)
                    break
                else
                    puts "No data#{!map_size ? " map size" : ""} in Map section"
                    correct = false
                    break
                end
            elsif(i.include? "mapsize")
                i = i.split("=")
                begin
                    @data[:map_size]=eval i[1]
                    map_size = true
                rescue
                    puts "Incorrect command line #{@read_line}"
                    correct = false
                    break
                end
            elsif(i == "")
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
            "error"
        end
    end
    def user(file)
        correct = true
        name = false
        location = false
        file.each_line{|i|
            i = i.chomp("\n")
            @read_line += 1
            if(i == "end")
                if(name && location)
                    break
                else
                    puts "No data#{!name ? " name" : ""}#{!location ? " location" : ""} in User section"
                    correct = false
                    break
                end
            elsif(i.include? "name")
                begin
                    i = i.split("=")
                    @data[:user][:name] = i[1].strip
                    name = true
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
                    location = true
                rescue
                    puts "Incorrect command line #{@read_line}"
                    correct = false
                    break
                end
            elsif(i == "")
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
            "error"
        end
    end
    def driver(file)
        correct = true
        state = {
            name:[],
            location:[]
        }
        file.each_line {|i|
            i = i.chomp("\n")
            @read_line += 1
            if(i == "end")
                if(state[:name].length != state[:location].length)
                    puts "Driver data mismatch"
                    correct = false
                    break
                else
                    break
                end
            elsif(i.include? "name")
                begin
                    i = i.split("=")
                    i[1] = i[1].strip
                    if(state[:name].include? i[1])
                        puts "Driver name duplicate in line #{@read_line}"
                        correct = false
                        break
                    else
                        @data[:driver][i[1]] = {}
                        state[:name].push i[1]
                    end
                rescue
                    puts "Incorrect command line #{@read_line}"
                    correct = false
                    break
                end
            elsif(i.include? "location")
                begin
                    i = i.split("=")
                    loc = i[1].split(",").collect! {|i| eval i}
                    # if(state[:name].length == 0)
                    # end
                    if (@data[:driver][state[:name][-1]].empty?) 
                        if(state[:location].include? loc)
                            puts "Driver location duplicate in line #{@read_line}"
                            correct = false
                            break
                        else
                            @data[:driver][state[:name][-1]][:location] = loc
                            state[:location].push loc
                        end
                    else
                        puts "Driver data mismatch name in line #{@read_line}"
                        correct = false
                        break
                    end
                rescue
                    puts "Incorrect command line #{@read_line}"
                    correct = false
                    break
                end
            elsif(i.include? "rating")
                begin
                    i = i.split("=")
                    if(state[:name].length == 0)
                        puts "Driver data mismatch, no driver name"
                        correct = false
                        break
                    end
                    @data[:driver][state[:name][-1]][:rating] = eval i[1]
                rescue => exception
                    puts "Incorrect command line #{@read_line}"
                    correct = false
                    break
                end
            elsif(i == "")
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
            "error"
        end
    end
    def store(file)
        correct = true
        state ={
            name:[]
            location:[]
        }
        file.each_line {|i|
            i = i.chomp("\n")
            @read_line += 1
            if(i == "end")
                if(state[:name].length != state[:location].length)
                    puts "Store data mismatch"
                    correct = false
                    break
                else
                    break
                end
            elsif(i.include? "name")
                begin
                    i = i.split("=")
                    i[1] = i[1].strip
                    @data[:store][i[1]] = {}
                    state[:name].push i[1]
                rescue
                    puts "Incorrect command line #{@read_line}"
                    correct = false
                    break
                end
            end
        }
    end
end

test = FileParser.new("input.txt")
print "#{test.read_file} \n"
print "#{test.data} \n"
test.close