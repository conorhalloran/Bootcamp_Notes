class Cookie
    SUGAR_CALORIES = 4
    BUTTER_CALORIES = 9
    def initialize(sugar, butter)
        @sugar, @butter = sugar, butter
    end

    def calorie_count
        @sugar * SUGAR_CALORIES + @butter * BUTTER_CALORIES
    end

##### END #####
end
