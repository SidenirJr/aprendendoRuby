#!/usr/bin/env ruby
# frozen_string_literal: true

# Exemplo 5: Conta Bancária
# Demonstra Programação Orientada a Objetos

class ContaBancaria
  attr_reader :numero, :titular, :saldo

  def initialize(numero, titular, saldo_inicial = 0)
    @numero = numero
    @titular = titular
    @saldo = saldo_inicial
    @historico = []
    registrar("Conta criada com saldo inicial de R$ #{@saldo}")
  end

  def depositar(valor)
    return puts "Valor inválido!" if valor <= 0

    @saldo += valor
    registrar("Depósito de R$ #{valor}")
    puts "✓ Depósito realizado! Novo saldo: R$ #{@saldo}"
  end

  def sacar(valor)
    if valor <= 0
      puts "Valor inválido!"
    elsif valor > @saldo
      puts "Saldo insuficiente!"
    else
      @saldo -= valor
      registrar("Saque de R$ #{valor}")
      puts "✓ Saque realizado! Novo saldo: R$ #{@saldo}"
    end
  end

  def transferir(valor, conta_destino)
    if valor > @saldo
      puts "Saldo insuficiente para transferência!"
    else
      @saldo -= valor
      conta_destino.receber_transferencia(valor, self)
      registrar("Transferência de R$ #{valor} para #{conta_destino.titular}")
      puts "✓ Transferência realizada!"
    end
  end

  def receber_transferencia(valor, conta_origem)
    @saldo += valor
    registrar("Recebimento de R$ #{valor} de #{conta_origem.titular}")
  end

  def extrato
    puts "\n=== Extrato da Conta #{@numero} ==="
    puts "Titular: #{@titular}"
    puts "Saldo: R$ #{@saldo}"
    puts "\nHistórico:"
    @historico.each_with_index do |transacao, i|
      puts "#{i + 1}. #{transacao}"
    end
  end

  private

  def registrar(mensagem)
    timestamp = Time.now.strftime("%d/%m/%Y %H:%M")
    @historico << "#{timestamp} - #{mensagem}"
  end
end

# Usando a classe ContaBancaria
puts "=== Sistema Bancário ==="

conta1 = ContaBancaria.new(1001, "João Silva", 1000)
conta2 = ContaBancaria.new(1002, "Maria Santos", 500)

conta1.depositar(500)
conta1.sacar(200)
conta1.transferir(300, conta2)

conta1.extrato
conta2.extrato

# Executar: ruby exemplos/05_conta_bancaria.rb
