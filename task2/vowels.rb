vowels = {}
alfabet = ('a'..'z').to_a

alfabet.each do |letter|
  vowels[letter.to_sym] = alfabet.index(letter) + 1 if %w(a e i o u y).include?(letter)
end

puts vowels