vowels = Hash.new
alfabet = ('a'..'z').to_a

%w(a e i o u y).each do |s|
  value = alfabet.index(s)
  vowels[s.to_sym] = value + 1
end
