class Student
    def initialize (first_name, last_name, score)
    @first_name, @last_name, @score = first_name, last_name, score
    end

    def full_name
        "#{@first_name} #{@last_name}"
    end

    def grade
        if @score >= 90
            "A"
        elsif @score >= 75
            "B"
        elsif @score >= 60
            "C"
        elsif @score >= 50
            "D" 
        else 
            "F"
        end
    end
end
