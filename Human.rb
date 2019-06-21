require './Thing.rb'
class Human
    include Thing
    attr_reader :name
    def initialize(name)
        @name = name
    end
    def to_s
        @name
    end
    def to_sym
        @name.to_sym
    end
end