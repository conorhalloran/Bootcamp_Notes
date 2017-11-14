def awesome_method
    my_obj = { lucky_number: rand(100) }
    yeild(my_obj) if block_given?
    my_obj.each do |k, v|
        puts "key is #{k} and value is #{v}"
    end
end

awesome_method do |obj|
    obj[:greeting] = "Hello World"
end

awesome_method do |obj|
    obj[:greeting] = "Hello World"
    obj[:greeting1] = "Hello World 1"
    obj[:greeting2] = "Hello World 2"
    obj[:greeting3] = "Hello World 3"
    obj[:greeting4] = "Hello World 4"
end
