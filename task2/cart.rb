sum =0
loop do
  puts "Введите название товара (стоп для завершения)"
  break if gets.chomp == 'стоп'
  puts "Количество товара"
  kol = gets.chomp.to_f
  puts " Цена за единицу товара"
  price = gets.chomp.to_f
  sum += price * kol
end
puts "Сумма корзины: #{sum}"
