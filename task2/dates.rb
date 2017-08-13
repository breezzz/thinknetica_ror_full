months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts "введи дату:"
puts "введи день"
day = gets.chomp.to_i
puts "введи месяц"
month = gets.chomp.to_i
puts "введи год"
year = gets.chomp.to_i

months[1] = 29 if (((year % 4 == 0) && !(year % 100 == 0)) || ((year % 4 == 0) && (year % 100 == 0) && (year % 400 == 0)))

sum = 0

(0..(month - 2)).each {|i| sum += months[i]} if month > 1

sum += day

puts "порядковый номер даты #{sum}"
