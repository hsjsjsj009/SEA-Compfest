class MapNode
    attr_reader :content_active
    def initialize(content='.')
        @content_active = content
        @previous_content = content == '.' ? ['.'] : ['.',content]
        @neighbour_node = []
    end
    def add_content(content)
        @content_active = content
        @previous_content.push content
    end
    def remove_content(content)
        @previous_content.delete content
        @content_active = @previous_content[-1]
    end
    def to_s
        @content_active.to_s + (@previous_content.length > 2 ? "[#{@previous_content.length - 1}]" : "")
    end
end