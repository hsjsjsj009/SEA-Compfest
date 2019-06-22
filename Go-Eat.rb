require './User.rb'
require './FileParser.rb'

def file_name
    name = "history.txt"
    found = false
    i = 1
    while !found
        if(File.file?(name))
            name = "history#{i}.txt"
            i += 1
            next
        else
            found = true
        end
    end
    name
end

if(ARGV.empty?)
    output_stream = open(file_name, "w")
    user = User.new("%", output_stream)
    user.run_app
elsif(ARGV.length == 3)
    first, second, third = ARGV.collect! {|i|
        begin
            eval i
        rescue
            i
        end }
    if(first.class.to_s != "Integer" || second.class.to_s != "Integer" || third.class.to_s != "Integer")
        puts "Wrong Command"
    else
        output_stream = open(file_name, "w")
        user = User.new("%",output_stream)
        user.run_app(first,{},{},[second,third])
    end
elsif(ARGV.length == 1)
    begin
        first = eval ARGV.first
    rescue => exception
        first = ARGV.first
    end
    if(first.class.to_s != "String")
        puts "Wrong Command"
    else
        if(!File.file?(first))
            puts "File doesn't exist"
        else
            file_parse = FileParser.new(first)
            system("clear")
            puts "Reading file...."
            sleep(1)
            if (file_parse.read_file != "error")
                puts "Done"
                sleep(0.5)
                output_stream = open(file_name,"w")
                user = User.new(file_parse.data[:user][:name],output_stream)
                user.run_app(file_parse.data[:map_size],file_parse.data[:driver],file_parse.data[:store],file_parse.data[:user][:location])
            end
        end
    end
end


