require './User.rb'
if(ARGV.empty?)
    output_stream = open("history.txt", "w")
    user = User.new("%", output_stream)
    user.run_app
elsif(ARGV.length == 3)
    output_stream = open("history.txt", "w")
    first, second, third = ARGV.collect! {|i| i.to_i}
    user = User.new("%",output_stream)
    user.run_app(first,{},{},[second,third])
end
