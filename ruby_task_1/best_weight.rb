puts "Hi man - pls write your name and height"
print "Name -> " 
name = gets.chomp.capitalize!
print "Height -> " 
height = gets.to_i
if (height-110)*1.15 <= 0
    puts "Ok #{name} your weight is normal"
else
    puts " #{name}!!! you are very fat man, go to the gym "
end
