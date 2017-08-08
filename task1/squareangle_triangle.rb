length_side = []
puts "Введите длины сторон треугольника"
3.times do |i|
  puts "Сторона_#{i}?"
  length_side[i]  = gets.chomp.to_f
end
is_have_two_equal_sides = false
is_have_all_equal_sides = false
is_squareangle = false


# проверка равносторонности
if (length_side[0] == length_side[1]) && (length_side[1] == length_side[2])
  is_have_all_equal_sides = true
else
# проверка равнобедренности
  count = 0
  3.times do |g|
    if (length_side[g] == length_side[g-1]) || (length_side[g] ==length_side[g-2])
      count += 1
    end
  end
  is_have_two_equal_sides = true if count > 0
end

# проверка прямоугольности
length_side.sort!
if  (length_side[0] ** 2) + (length_side[1] ** 2) == (length_side[2] ** 2)
  is_squareangle = true
end

puts "Треугольник равносторонний" if is_have_all_equal_sides
puts "Треугольник равнобедренный" if is_have_two_equal_sides && !is_have_all_equal_sides
puts "Треугольник прямоугольный" if is_squareangle
