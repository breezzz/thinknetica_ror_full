day_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31,]

puts "Введите дату в виде день/месяц/год?"
date = gets.chomp.split('/').map {|d| d.to_i}

is_leap_year = date[2] % 4 == 0

if is_leap_year && !(date[2] % 100 == 0)
  if !is_leap_year
    is_leap_year = date[2] % 400 == 0
  end
end

day_in_months[1] = 29 if is_leap_year
sum = 0
if date[1] - 1 > 0
  for i in 0..(date[1] - 2)
    sum +=day_in_months[i]
  end
end
sum = sum + date[0]

puts "порядковый номер даты #{sum}"