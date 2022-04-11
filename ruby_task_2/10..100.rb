
Array=[]
i = 5
p = i

# !!while loop!!

=begin

while i <= 99
        i +=5 
        Array << i
         
end

puts "Array = #{Array}"
=end 

# !!untile loop!!

=begin
until i == 100
    i += 5
    Array << i  
end

puts "Array = #{Array}"

=end 

# !!loop do!!

=begin

loop do
    i += 5
    Array << i 
break if i >= 100
end   

puts "Array = #{Array}"

=end 

# !!for loop!!

=begin

for i in 1..19
p += 5
Array << p
end

puts "Array = #{Array}"

=end 