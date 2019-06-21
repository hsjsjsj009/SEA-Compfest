class MapNode
    attr_reader :content_active, :information
    def initialize
        @content_show = '.'
        @content_active = ['.']
        @neighbour_node = []
        @information = ""
    end
    def add_content(content)
        if (@information == "")
            @content_show = content
            @content_active.push content
            @information = content.class.to_s
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
end