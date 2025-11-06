#!/usr/bin/env ruby
# frozen_string_literal: true

# Exemplo 6: Jogo de Adivinhação
# Demonstra lógica, loops e interação com usuário

puts "=== Jogo de Adivinhação ==="
puts "Vou pensar em um número de 1 a 100."
puts "Tente adivinhar!"
puts

numero_secreto = rand(1..100)
tentativas = 0
max_tentativas = 7

loop do
  print "\nDigite seu palpite: "
  palpite = gets.chomp.to_i
  tentativas += 1

  if palpite == numero_secreto
    puts "\n🎉 Parabéns! Você acertou!"
    puts "O número era #{numero_secreto}"
    puts "Você precisou de #{tentativas} tentativa(s)"
    break
  elsif tentativas >= max_tentativas
    puts "\n😞 Você perdeu!"
    puts "O número era #{numero_secreto}"
    break
  elsif palpite < numero_secreto
    puts "📈 Muito baixo! Tente um número maior."
  else
    puts "📉 Muito alto! Tente um número menor."
  end

  restantes = max_tentativas - tentativas
  puts "Você tem #{restantes} tentativa(s) restante(s)"
end

print "\nDeseja jogar novamente? (s/n): "
if gets.chomp.downcase == 's'
  exec($PROGRAM_NAME)  # Reinicia o programa
else
  puts "Até logo!"
end

# Executar: ruby exemplos/06_jogo_adivinhacao.rb
