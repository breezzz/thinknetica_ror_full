fibonacci_numbers = [0, 1]
n = 2
temp = 0

while temp < 100
  temp= fibonacci_numbers[n-1] + fibonacci_numbers[n-2]
  fibonacci_numbers[n] = temp if temp < 100
  n += 1
end

puts fibonacci_numbers