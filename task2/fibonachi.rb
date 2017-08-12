f_numbers = []
f_numbers[0] = 0
f_numbers[1] = 1
n = 2

loop do
  temp = f_numbers[n-1] + f_numbers[n-2]
  break if temp > 100
  f_numbers[n] = temp
  n += 1
end
