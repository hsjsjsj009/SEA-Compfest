require './User.rb'
require './FileParser.rb'
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
            output_stream = open(file_name,"w")

    end
end

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
