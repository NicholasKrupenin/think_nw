puts "Hello **0/** let's do the math (Quadratic equation)"
puts 'ах^2 + bx + c = 0'
print "Enter coefficient a -> "
a = gets.to_i
print "Enter coefficient b -> "
b = gets.to_i
print "Enter coefficient c -> "
c = gets.to_i
D = (b**2-4*a*c).to_i
puts "No roots. Discriminant = #{D} " if D<0
puts "Single roots. Discriminant = #{D}, root = #{-b/2*a}" if D==0
puts "Double roots. Discriminant = #{D}, root_1 = #{(-b+Math.sqrt(D))/2*a}, root_2 = #{(-b-Math.sqrt(D))/2*a}" if D>0