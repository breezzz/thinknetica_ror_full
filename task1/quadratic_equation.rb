index = [ 'A', 'B', 'C']
koeffs = []
puts "Введите коэффициенты уравнения Ax**2 + Bx + C"
3.times {|i|
  puts "Коэффициент_#{index[i]}?"
  koeffs[i]  = gets.chomp.to_i
}
diskriminant = (koeffs[1] ** 2 - 4 * koeffs[0] * koeffs[2])

if koeffs[0] != 0 && diskriminant >=0
  root_1 = (-koeffs[1] + Math.sqrt(diskriminant))/(2*koeffs[0])
  root_2 = (-koeffs[1] - Math.sqrt(diskriminant))/(2*koeffs[0])
end

if diskriminant < 0
  puts "Дискриминант #{diskriminant}, корней нет"
elsif diskriminant == 0
  puts "Дискриминант #{diskriminant}, один корень #{root_1} "
else
  puts "Дискриминант #{diskriminant}, первый корень #{root_1}, второй корень #{root_2}  "
end


