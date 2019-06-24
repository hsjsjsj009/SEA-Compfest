module Thing
    attr_reader :x,:y
    def set_location(x,y)
        @x = x
        @y = y
    end
    def get_location
        [@x,@y]
    end
    def distance_to_point(coordinates)
        value = (((@x - coordinates[0])**2) + 
        ((@y - coordinates[1])**2)) ** 0.5
        value
    end
    # def path_to_point(coordinates)
    #     start = get_location
    #     route = [get_location]
    #     arrive = false
    #     direction = :x
    #     while !arrive
    #         if start == coordinates
    #             arrive = true
    #         elsif (direction == :x)
    #             if(coordinates[0] > start[0])
    #                 if(@app.get_thing([start[0]+1,start[1]]).information == "Store")
    #                     if(start[1] == coordinates[1])
    #                         if(start[1]-1 >= 0 && start[1]-1 < @app.map_size)
    #                             start[1] -= 1
    #                         elsif (start[1]+1 >= 0 && start[1]+1 < @app.map_size)
    #                             start[1] += 1
    #                         end
    #                     else
    #                         direction = :y
    #                         next
    #                     end
    #                 else
    #                     start[0] += 1
    #                     route.push [start[0],start[1]]
    #                 end
    #             elsif (coordinates[0] < start[0])
    #                 if(@app.get_thing([start[0]-1,start[1]]).information == "Store")
    #                     direction = :y
    #                     next
    #                 else
    #                     start[0] -= 1
    #                     route.push [start[0],start[1]]
    #                 end
    #             else 
    #                 direction = :y
    #             end
    #         else 
    #             if(coordinates[1] > start[1])
    #                 if(@app.get_thing([start[0],start[1]+1]).information == "Store")
    #                     direction = :x
    #                     next
    #                 else
    #                     start[1] += 1
    #                     route.push [start[0],start[1]]
    #                 end
    #             elsif (coordinates[1] < start[1])
    #                 if(@app.get_thing([start[0],start[1]-1]).information == "Store")
    #                     direction = :x
    #                     next
    #                 else
    #                     start[1] -= 1
    #                     route.push [start[0],start[1]]
    #                 end
    #             else 
    #                 direction = :x
    #             end
    #         end
    #     end
    #     route
    #     print "#{route}\n"
    # end                 
end