puts "Ваше имя?"
name = gets.chomp
puts "Ваш рост?"
height = gets.chomp.to_f

ideal_weight =  height - 110

if ideal_weight >= 0
  puts "#{name}, идеальный вес для вас #{ideal_weight}"
else
  puts "Ваш вес уже оптимальный"
end
