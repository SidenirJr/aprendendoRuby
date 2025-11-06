#!/usr/bin/env ruby
# frozen_string_literal: true

# Exemplo 4: Lista de Tarefas
# Demonstra arrays, hashes e estruturas condicionais

tarefas = []

def menu
  puts "\n=== Lista de Tarefas ==="
  puts "1. Adicionar tarefa"
  puts "2. Listar tarefas"
  puts "3. Remover tarefa"
  puts "4. Sair"
  print "Escolha uma opção: "
end

loop do
  menu
  opcao = gets.chomp.to_i

  case opcao
  when 1
    print "Digite a tarefa: "
    tarefa = gets.chomp
    tarefas << tarefa
    puts "✓ Tarefa adicionada!"

  when 2
    if tarefas.empty?
      puts "Nenhuma tarefa cadastrada."
    else
      puts "\n=== Suas Tarefas ==="
      tarefas.each_with_index do |tarefa, index|
        puts "#{index + 1}. #{tarefa}"
      end
    end

  when 3
    if tarefas.empty?
      puts "Nenhuma tarefa para remover."
    else
      puts "\n=== Tarefas ==="
      tarefas.each_with_index { |t, i| puts "#{i + 1}. #{t}" }
      print "Digite o número da tarefa a remover: "
      indice = gets.chomp.to_i - 1

      if indice >= 0 && indice < tarefas.length
        removida = tarefas.delete_at(indice)
        puts "✓ Tarefa '#{removida}' removida!"
      else
        puts "✗ Número inválido!"
      end
    end

  when 4
    puts "Até logo!"
    break

  else
    puts "Opção inválida!"
  end
end

# Executar: ruby exemplos/04_lista_tarefas.rb
