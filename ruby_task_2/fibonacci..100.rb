
print "Enter number of fibo. -> "
n = gets.to_i 
fib = []
a=0
b=1
for i in 1..n
    fib.push(a)
    a,b = b, a+b
    break if a >= n
end
print fib

