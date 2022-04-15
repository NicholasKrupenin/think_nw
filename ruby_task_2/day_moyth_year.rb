print "day of the month ~> "
d = gets.to_i
print "month of the year ~> "
m = gets.to_i
print "year ~> "
y = gets.to_i

month = {1=> 31,2=> 28,3=> 31,4=> 30,5=> 31,6=> 30,7=> 31,8=> 31,9=> 30,10=> 31,11=> 30,12=> 31}

if y%100 == 0 
    f y%400 == 0
    month.store(2, 29)
end

elsif y%4 == 0
    month.store(2, 29)
end

count = month.select { |a,b| (a)<=m} 
    
print "Count ~~>  #{count.values.sum - month[m] + d}"

  



