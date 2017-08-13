cart = {}
total = 0

loop do
  puts "Введите наименование товара (стоп для завершения)"
  name = gets.chomp
  break if name == 'стоп'
  puts "Количество товара"
  quantity = gets.chomp.to_f
  puts "Цена за единицу товара"
  price = gets.chomp.to_f
  cost = price * quantity
  total += cost
  cart[name] = {price: price, quantity: quantity}
end

puts "Корзина: "
puts "#----------------------------------------------------------#"
puts "Наименование		Количество		Цена		Стоимость"
puts "#----------------------------------------------------------#"
cart.each do |name, specification|
  puts "#{name}				#{specification[:quantity]}				#{specification[:price]}			#{specification[:price] * specification[:quantity]}"
end
puts "#----------------------------------------------------------#"
puts "Итого: #{total}"
