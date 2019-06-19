class Food
    attr_reader :price, :name
    attr_writer :price
    def initialize(name,price)
        @name = name
        @price = price
    end
    def to_s
        @name
    end
end