require './MapNode.rb'

class Map
    attr_reader :list_thing, :list_coordinates
    def initialize(size)
        @size = size
        @list_thing = {}
        MapNode.map_size = size
        @map_node = Array.new(size) {|i| Array.new(size) {|j| MapNode.new(j,i)}}
        @list_coordinates = []
    end
    def add_thing(dict)
        dict.each {|i,j|
            i.set_location(j[1],j[0])
            @list_thing[i]=j
            @list_coordinates.push j
            @map_node[j[1]][j[0]].add_content(i)
        }
    end
    def move_thing(dict)
            dict.each { |i,j| 
                @list_thing[i]=j
                last_coordinate = i.get_location
                @map_node[last_coordinate[1]][last_coordinate[0]].remove_content(i)
                @map_node[j[1]][j[0]].add_content(i)
                i.set_location(j[1],j[0])
            }
    end
    def remove_thing(dict)
        dict.each {|i,j| 
            node = get_thing(j)
            node.remove_content(i)
        }
    end
    def get_thing(coordinate)
        @map_node[coordinate[0]][coordinate[1]]
    end
    def check_area(coordinate)
        x = coordinate[1]
        y = coordinate[0]
        area = [
            [x-1,y],
            [x,y-1],
            [x+1,y],
            [x,y+1]
        ]
        state = true
        area.each {|i|
            if(i[0] < @size && i[1] < @size && i[0] >= 0 && i[1] >= 0)
                if(@list_coordinates.include? i)
                    state = false
                    break
                end
            end
        }
        state
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
    def self.path_to_point(start,finish)
        start.store = false
        finish.store = false
        

    end
    def connect_node
        system("clear")
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