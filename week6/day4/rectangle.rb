class Rectangle 
    
    def initialize (length, height)
        @length, @height = length, height
    end

    def area
        @length * @height
    end

    def is_square
        @length == @height
    end

    def perimeter
        @length * 2 + @height * 2
    end

end
