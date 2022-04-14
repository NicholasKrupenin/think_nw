
arr = Hash.new
price_total = 0



loop do
    print "\nEnter name product (\"stop\" to esc) ~~> "
    name = gets.to_s.chomp
    break if name == "stop"
    print "Enter price product ~~> "
    price = gets.to_i   
    print "Enter quantity product ~~> "
    quantity = gets.to_f

        arr[name] = {price => quantity}

price_total += price*quantity 

  
puts "\nTotal price #{name} = #{price*quantity}"      


end


puts "\nTotal summ: #{price_total} "
puts "\nHash: #{arr} "


