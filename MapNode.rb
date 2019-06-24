class MapNode
    attr_reader :content_active, :information, :neighbour_location, :neighbour_node
    attr_accessor :f,:g,:h, :store
    @@map_size = 0
    def initialize(x,y)
        @x = x
        @y = y
        @f = 0
        @g = 0
        @h = 0
        @store = false
        @content_show = '.'
        @content_active = ['.']
        @neighbour_node = []
        @neighbour_location = []
        @information = ""
        @previous_node = nil
    end
    def self.map_size=(size)
        @@map_size =size
    end
    def find_neighbour(map)
        area = [
            [@x-1,@y],
            [@x,@y-1],
            [@x+1,@y],
            [@x,@y+1]
        ]
        area.each{|i|
            if(i[0] >= 0 && i[0] < @@map_size && i[1] >= 0 && i[1] < @@map_size)
                if(map[i[1]][i[0]].store)
                    next
                else
                    @neighbour_node.push map[i[1]][i[0]].to_s
                    @neighbour_location.push i
                end
            end
        }
    end
    def reset_value
        @f = 0
        @g = 0
        @h = 0
        if(@information == "Store")
            @store = true
        end
    end
    def add_content(content)
        if (@information == "")
            @content_show = content
            @content_active.push content
            @information = content.class.to_s
            if(content.class.to_s == "Store")
                @store = true
            end
        else
            if (@information == "Driver")
                @content_show = content
                @content_active.push content
            else 
                @content_active.push content
            end
        end
    end
    def remove_content(content)
        if (@information == "Driver")
            @content_active.delete content
            @content_show = @content_active[-1]
            @information = @content_show == "." ? "" : @content_show.class.to_s
        else 
            @content_active.delete content
        end
    end
    def to_s
        @content_show.to_s + (@content_active.length > 2 ? "[#{@content_active.length - 1}]" : "")
    end
    def get_position
        [@x,@y]
    end
end