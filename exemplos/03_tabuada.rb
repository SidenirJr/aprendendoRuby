#!/usr/bin/env ruby
# frozen_string_literal: true

# Exemplo 3: Tabuada
# Demonstra laços de repetição e formatação

print "Digite um número para ver a tabuada: "
numero = gets.chomp.to_i

puts "\n=== Tabuada do #{numero} ==="

# Usando times
10.times do |i|
  multiplicador = i + 1
  resultado = numero * multiplicador
  puts "#{numero} × #{multiplicador} = #{resultado}"
end

# Alternativa com upto
puts "\n=== Usando upto ==="
1.upto(10) do |i|
  puts "#{numero} × #{i} = #{numero * i}"
end

# Alternativa com each e range
puts "\n=== Usando each ==="
(1..10).each do |i|
  puts "#{numero} × #{i} = #{numero * i}"
end

# Executar: ruby exemplos/03_tabuada.rb
