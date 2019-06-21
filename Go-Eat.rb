require './User.rb'
if(ARGV.empty?)
    user = User.new("%")
    user.run_app
elsif(ARGV.length == 3)
    first, second, third = ARGV.collect! {|i| i.to_i}
    user = User.new("%")
    user.run_app(first,{},{},[second,third])
end
