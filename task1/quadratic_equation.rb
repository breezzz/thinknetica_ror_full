index = [ 'A', 'B', 'C']
koeffs = []
puts "Введите коэффициенты уравнения Ax**2 + Bx + C"
3.times {|i|
  puts "Коэффициент_#{index[i]}?"
  koeffs[i]  = gets.chomp.to_f
}
diskriminant = koeffs[1] ** 2 - 4 * koeffs[0] * koeffs[2]
univ_koef = -koeffs[1]/ (2*koeffs[0]) if koeffs[0] != 0

if diskriminant < 0
  puts "Дискриминант #{diskriminant}, корней нет"
elsif diskriminant == 0
  puts "Дискриминант #{diskriminant}, один корень #{univ_koef} "
else
  square_root = Math.sqrt(diskriminant) / (2*koeffs[0])
  root_1 = univ_koef + square_root
  root_2 = univ_koef - square_root
  puts "Дискриминант #{diskriminant}, первый корень #{root_1}, второй корень #{root_2}"
end
