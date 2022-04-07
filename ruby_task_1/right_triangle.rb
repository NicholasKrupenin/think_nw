puts "\nHello **0/** let's do the math (right triangle)"
print "\nEnter side A -> "
side_a = gets.to_i
print "Enter side B -> "
side_b = gets.to_i
print "Enter side C -> "
side_c = gets.to_i
#
#Searching equilateral or isosceles triangle.
#
if  side_a == side_b && side_b == side_c
    puts "\n ~~> It's equilateral triangle"
elsif side_a == side_b || side_b == side_c || side_a == side_c
    puts "\n It's isosceles triangle"
#
#If triangle is not a equilateral or isosceles we search hypotenuse.
#
elsif side_a>side_b && side_a>side_c
        if side_b**2+side_c**2 == side_a**2
        puts "\n ~~> it's right triangle, A - hypotenuse"    
        end
elsif side_b>side_a && side_b>side_c
        if side_a**2+side_c**2 == side_b**2
        puts "\n ~~> it's right triangle, B - hypotenuse" 
        end
elsif side_c>side_a && side_c>side_b 
        if side_a**2+side_b**2 == side_c**2
        puts "\n ~~> it's right triangle, C - hypotenuse"
        end
elsif side_a != side_b && side_b != side_c
        puts "\n ~~> it's " 
end



    

    




