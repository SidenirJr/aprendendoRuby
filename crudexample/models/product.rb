# frozen_string_literal: true

require_relative '../config/database'

# Model para representar e manipular produtos
class Product
  attr_accessor :id, :name, :description, :price, :quantity, :created_at, :updated_at

  def initialize(attributes = {})
    @id = attributes['id'] || attributes[:id]
    @name = attributes['name'] || attributes[:name]
    @description = attributes['description'] || attributes[:description]
    @price = attributes['price'] || attributes[:price]
    @quantity = attributes['quantity'] || attributes[:quantity]
    @created_at = attributes['created_at'] || attributes[:created_at]
    @updated_at = attributes['updated_at'] || attributes[:updated_at]
  end

  # Buscar todos os produtos
  def self.all
    db = Database.connection
    rows = db.execute('SELECT * FROM products ORDER BY id DESC')
    rows.map { |row| new(row) }
  end

  # Buscar produto por ID
  def self.find(id)
    db = Database.connection
    row = db.execute('SELECT * FROM products WHERE id = ?', [id]).first
    row ? new(row) : nil
  end

  # Criar novo produto
  def self.create(attributes)
    product = new(attributes)
    product.save
    product
  end

  # Salvar produto (insert ou update)
  def save
    if @id
      update
    else
      insert
    end
  end

  # Atualizar produto existente
  def update
    return false unless valid?

    db = Database.connection
    db.execute(
      'UPDATE products SET name = ?, description = ?, price = ?, quantity = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?',
      [@name, @description, @price, @quantity, @id]
    )
    true
  end

  # Deletar produto
  def destroy
    return false unless @id

    db = Database.connection
    db.execute('DELETE FROM products WHERE id = ?', [@id])
    true
  end

  # Deletar produto por ID (método de classe)
  def self.destroy(id)
    product = find(id)
    product&.destroy
  end

  # Buscar produtos por nome
  def self.search(query)
    db = Database.connection
    rows = db.execute(
      'SELECT * FROM products WHERE name LIKE ? OR description LIKE ?',
      ["%#{query}%", "%#{query}%"]
    )
    rows.map { |row| new(row) }
  end

  # Contar total de produtos
  def self.count
    db = Database.connection
    db.execute('SELECT COUNT(*) as count FROM products').first['count']
  end

  # Validações
  def valid?
    errors.empty?
  end

  def errors
    errors = []
    errors << 'Nome é obrigatório' if @name.nil? || @name.empty?
    errors << 'Preço é obrigatório' if @price.nil?
    errors << 'Preço deve ser positivo' if @price && @price <= 0
    errors << 'Quantidade deve ser >= 0' if @quantity && @quantity < 0
    errors
  end

  # Converter para Hash
  def to_hash
    {
      id: @id,
      name: @name,
      description: @description,
      price: @price,
      quantity: @quantity,
      created_at: @created_at,
      updated_at: @updated_at
    }
  end

  # Converter para JSON
  def to_json(*_args)
    require 'json'
    to_hash.to_json
  end

  private

  # Inserir novo produto no banco
  def insert
    return false unless valid?

    db = Database.connection
    db.execute(
      'INSERT INTO products (name, description, price, quantity) VALUES (?, ?, ?, ?)',
      [@name, @description, @price, @quantity || 0]
    )
    @id = db.last_insert_row_id
    true
  end
end
