puts "Ваше имя?"
name = gets.chomp
puts "Ваш рост?"
height = gets.chomp.to_i
if height - 110 >= 0
  puts "#{name}, идеальный вес для вас #{height - 110}"
else
  puts "Ваш вес уже оптимальный"
end
