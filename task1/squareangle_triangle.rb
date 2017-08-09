puts "Введите длины сторон треугольника"
sides = %w(A B C).map do |side|
  puts "Сторона_#{side}?"
  gets.chomp.to_f
end

# проверка равносторонности
equilateral = (sides[0] == sides[1]) && (sides[1] == sides[2])

# проверка равнобедренности
count = 0
3.times do |g|
  if (sides[g] == sides[g-1]) || (sides[g] ==sides[g-2])
    count += 1
  end
end
isosceles = true if count > 0

# проверка прямоугольности
sides.sort!
rectangular =  (sides[0] ** 2) + (sides[1] ** 2) == (sides[2] ** 2)


puts "Треугольник равносторонний" if equilateral
puts "Треугольник равнобедренный" if isosceles && !equilateral
puts "Треугольник прямоугольный" if rectangular
puts "Треугольник обычный" if !rectangular && !isosceles && !equilateral

