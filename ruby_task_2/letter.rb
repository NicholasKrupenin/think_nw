
mounth = Hash[]
p=0
("a".."z").each do |i|
    p+=1
    mounth.store(i,p)
    end
   
mounth.each do |i,p| 
  if i == "a" || i == "e" || i == "i" || i == "o" || i == "u" || i == "y"
       puts p
        end
    end

