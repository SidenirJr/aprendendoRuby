# frozen_string_literal: true

require 'sqlite3'

# Configuração e gerenciamento do banco de dados SQLite
class Database
  DB_FILE = 'products.db'

  # Obtém a conexão com o banco de dados
  def self.connection
    @connection ||= SQLite3::Database.new(DB_FILE)
    @connection.results_as_hash = true
    @connection
  end

  # Cria as tabelas necessárias
  def self.setup
    connection.execute <<-SQL
      CREATE TABLE IF NOT EXISTS products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT,
        price REAL NOT NULL,
        quantity INTEGER DEFAULT 0,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
      );
    SQL

    puts "✓ Banco de dados configurado com sucesso!"
  end

  # Reseta o banco de dados (cuidado!)
  def self.reset!
    connection.execute('DROP TABLE IF EXISTS products')
    setup
    puts "✓ Banco de dados resetado!"
  end

  # Popula o banco com dados de exemplo
  def self.seed
    products = [
      { name: 'Notebook Dell', description: 'Notebook Dell Inspiron 15', price: 3500.00, quantity: 10 },
      { name: 'Mouse Logitech', description: 'Mouse sem fio', price: 89.90, quantity: 50 },
      { name: 'Teclado Mecânico', description: 'Teclado RGB', price: 450.00, quantity: 25 },
      { name: 'Monitor LG 24"', description: 'Monitor Full HD', price: 800.00, quantity: 15 },
      { name: 'Webcam Full HD', description: 'Webcam 1080p', price: 250.00, quantity: 30 }
    ]

    products.each do |product|
      connection.execute(
        'INSERT INTO products (name, description, price, quantity) VALUES (?, ?, ?, ?)',
        [product[:name], product[:description], product[:price], product[:quantity]]
      )
    end

    puts "✓ #{products.size} produtos adicionados ao banco!"
  end

  # Fecha a conexão
  def self.close
    @connection&.close
    @connection = nil
  end
end
