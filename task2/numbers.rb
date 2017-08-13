numbers_arr = []
(10..100).each {|n| numbers_arr << n if n % 5 == 0 }
puts numbers_arr