require './MapNode.rb'

class Map
    attr_reader :list_thing, :list_coordinates
    def initialize(size)
        @size = size
        @list_thing = {}
        @map_node = Array.new(size) {Array.new(size) {MapNode.new()}}
        @list_coordinates = []
    end
    def add_thing(dict)
        dict.each {|i,j|
            @list_thing[i]=j
            @list_coordinates.push j
            @map_node[j[0]][j[1]].add_content(i)
        }
    end
    def update_coordinates(dict)
            dict.each { |i,j| 
                @list_thing[i]=j
                last_coordinate = i.driver_location
                @map[last_coordinate[0]][last_coordinate[1]].remove_content(i)
                @map[j[0]][j[1]].add_content(i)
            }
    end
    def get_thing(coordinate)


    def check_area(coordinate)

    def print_map
        @map.each{ |i|
            i.each { |j|
                print j.to_s +" "
            }
            puts
        }
        puts
    end
end