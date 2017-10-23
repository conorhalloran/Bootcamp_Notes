class Dog

    def initialize
        @bones = []
    end

    def give_bone (size)
        @size = size
        if @bones.count == 3
            p 'I have too many bones'
        else
            @bones << size
        end
    end

    def eat_bone
        @bones.pop
    end

    def bone_count
        @bones.count
    end
#### END ####    
end