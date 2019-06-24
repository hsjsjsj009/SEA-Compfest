require './MapNode.rb'

class Map
    attr_reader :list_thing, :list_coordinates, :map_node
    def initialize(size)
        @size = size
        @list_thing = {}
        MapNode.map_size = size
        @map_node = Array.new(size) {|i| Array.new(size) {|j| MapNode.new(j,i)}}
    end
    def add_thing(dict)
        dict.each {|i,j|
            i.set_location(j[0],j[1])
            @list_thing[i.to_s]=j
            @map_node[j[1]][j[0]].add_content(i)
        }
    end
    def move_thing(dict)
            dict.each { |i,j| 
                @list_thing[i.to_s]=j
                last_coordinate = i.get_location
                @map_node[last_coordinate[1]][last_coordinate[0]].remove_content(i)
                @map_node[j[1]][j[0]].add_content(i)
                i.set_location(j[0],j[1])
            }
    end
    def remove_thing(dict)
        dict.each {|i,j| 
            @list_thing.delete(i.to_s)
            node = get_thing(j)
            node.remove_content(i)
        }
    end
    def get_thing(coordinate)
        @map_node[coordinate[1]][coordinate[0]]
    end
    def check_area(coordinate)
        if !(@list_thing.values.include?(coordinate)) 
            x = coordinate[0]
            y = coordinate[1]
            area = [
                [x-1,y],
                [x,y-1],
                [x+1,y],
                [x,y+1]
            ]
            state = true
            area.each {|i|
                if(i[0] < @size && i[1] < @size && i[0] >= 0 && i[1] >= 0)
                    if(@list_thing.values.include? i)
                        state = false
                        break
                    end
                end
            }
            state
        end
    end
    def print_map
        @map_node.each{ |i|
            i.each { |j|
                print "#{j.to_s} "
            }
            puts
        }
        puts
    end
    def path_to_point(start,finish)
        @map_node.each{ |i|
            i.each {|j|
                j.reset_value
            }
        }
        start.store=false
        finish.store=false
        closedSet = []
        openSet = []
        openSet.push start

        heuristic_val = ->(a,b) {
            return (a.x - b.x).abs + (a.y - b.y).abs
        }
        while openSet.length > 0
            current = openSet[0]
            openSet.each {|i|
                if(i.f < current.f)
                    current = i
                end

                if(i.f == current.f)
                    if(i.g > current.g)
                        current = i
                    end
                end
            }
            if current == finish
                # print "node #{current} - previous_node #{current.previous_node} -- loc previous_node #{current.previous_node.get_position}\n"
                temp_node = current
                route = []
                while (temp_node)
                    # print "node #{temp_node.previous_node} - previous_node #{temp_node.previous_node.previous_node} -- loc previous_node #{temp_node.previous_node.previous_node.get_position}\n"
                    route.push temp_node.get_position
                    temp_node = temp_node.previous_node
                end
                return route.reverse
            end

            openSet.delete(current)
            closedSet.push(current)
            neighbor_node = current.neighbour_node
            # print "#{neighbor_node.map {|i| i.to_s + " #{i.store} - previous #{i.previous_node.nil? ? "nil" : i.previous_node.get_position}"}} -- loc #{current.get_position} -- node #{current.to_s}\n"
            neighbor_node.each{|i|
                if (!i.store)
                    if(!closedSet.include? i)
                        tent_gScore = current.g + heuristic_val.call(i,current)
                        if !(openSet.include? i)
                            openSet.push i
                        elsif (tent_gScore >= i.g)
                            next
                        end

                        i.g = tent_gScore
                        i.h = heuristic_val.call(i,finish)
                        i.f = i.g + i.h
                        i.previous_node = current
                    end
                end
            }
        end
        -1
    end
    def connect_node
        puts("Generating Map")
        a = 0
        @map_node.each{|i|
            b = 0 
            i.each {|j|
                j.find_neighbour(@map_node)
            }
        }
        puts("Done")
    end
end