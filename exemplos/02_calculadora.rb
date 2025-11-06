#!/usr/bin/env ruby
# frozen_string_literal: true

# Exemplo 2: Calculadora Simples
# Demonstra variáveis, operadores e entrada de usuário

puts "=== Calculadora Simples ==="
puts

print "Digite o primeiro número: "
num1 = gets.chomp.to_f

print "Digite o segundo número: "
num2 = gets.chomp.to_f

# Realizar operações
soma = num1 + num2
subtracao = num1 - num2
multiplicacao = num1 * num2
divisao = num2.zero? ? "Divisão por zero!" : (num1 / num2)

# Exibir resultados
puts "\n=== Resultados ==="
puts "#{num1} + #{num2} = #{soma}"
puts "#{num1} - #{num2} = #{subtracao}"
puts "#{num1} × #{num2} = #{multiplicacao}"
puts "#{num1} ÷ #{num2} = #{divisao}"

# Executar: ruby exemplos/02_calculadora.rb
