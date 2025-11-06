# frozen_string_literal: true

require 'sinatra'
require 'json'
require_relative 'config/database'
require_relative 'models/product'

# Configurações do Sinatra
set :port, 4567
set :bind, '0.0.0.0'

# Configurar banco de dados ao iniciar
configure do
  Database.setup
end

# Middleware para parsear JSON no body
before do
  if request.content_type == 'application/json'
    request.body.rewind
    @request_payload = JSON.parse(request.body.read, symbolize_names: true) rescue {}
  end
end

# Headers para todas as respostas
before do
  content_type :json
  headers 'Access-Control-Allow-Origin' => '*',
          'Access-Control-Allow-Methods' => ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS']
end

# Rota raiz - Informações da API
get '/' do
  {
    message: 'API de Produtos - CRUD RESTful',
    version: '1.0.0',
    endpoints: {
      products: {
        list: 'GET /products',
        get: 'GET /products/:id',
        create: 'POST /products',
        update: 'PUT /products/:id',
        delete: 'DELETE /products/:id',
        search: 'GET /products/search?q=termo'
      }
    },
    total_products: Product.count
  }.to_json
end

# ===== CRUD ENDPOINTS =====

# CREATE - Criar novo produto
# POST /products
# Body: { "name": "...", "description": "...", "price": 99.90, "quantity": 10 }
post '/products' do
  begin
    product = Product.create(@request_payload)

    if product.valid?
      status 201
      {
        success: true,
        message: 'Produto criado com sucesso',
        product: product.to_hash
      }.to_json
    else
      status 422
      {
        success: false,
        errors: product.errors
      }.to_json
    end
  rescue StandardError => e
    status 500
    {
      success: false,
      error: e.message
    }.to_json
  end
end

# READ - Listar todos os produtos
# GET /products
get '/products' do
  begin
    products = Product.all

    {
      success: true,
      count: products.size,
      products: products.map(&:to_hash)
    }.to_json
  rescue StandardError => e
    status 500
    {
      success: false,
      error: e.message
    }.to_json
  end
end

# READ - Buscar produto por ID
# GET /products/:id
get '/products/:id' do
  begin
    product = Product.find(params[:id])

    if product
      {
        success: true,
        product: product.to_hash
      }.to_json
    else
      status 404
      {
        success: false,
        error: 'Produto não encontrado'
      }.to_json
    end
  rescue StandardError => e
    status 500
    {
      success: false,
      error: e.message
    }.to_json
  end
end

# UPDATE - Atualizar produto
# PUT /products/:id
# Body: { "name": "...", "price": 99.90, ... }
put '/products/:id' do
  begin
    product = Product.find(params[:id])

    unless product
      status 404
      return {
        success: false,
        error: 'Produto não encontrado'
      }.to_json
    end

    # Atualizar atributos
    product.name = @request_payload[:name] if @request_payload[:name]
    product.description = @request_payload[:description] if @request_payload.key?(:description)
    product.price = @request_payload[:price] if @request_payload[:price]
    product.quantity = @request_payload[:quantity] if @request_payload.key?(:quantity)

    if product.save
      {
        success: true,
        message: 'Produto atualizado com sucesso',
        product: product.to_hash
      }.to_json
    else
      status 422
      {
        success: false,
        errors: product.errors
      }.to_json
    end
  rescue StandardError => e
    status 500
    {
      success: false,
      error: e.message
    }.to_json
  end
end

# DELETE - Deletar produto
# DELETE /products/:id
delete '/products/:id' do
  begin
    product = Product.find(params[:id])

    unless product
      status 404
      return {
        success: false,
        error: 'Produto não encontrado'
      }.to_json
    end

    product.destroy

    {
      success: true,
      message: 'Produto deletado com sucesso'
    }.to_json
  rescue StandardError => e
    status 500
    {
      success: false,
      error: e.message
    }.to_json
  end
end

# SEARCH - Buscar produtos por nome/descrição
# GET /search?q=termo
get '/search' do
  begin
    query = params[:q]

    if query.nil? || query.empty?
      status 400
      return {
        success: false,
        error: 'Parâmetro q (query) é obrigatório'
      }.to_json
    end

    products = Product.search(query)

    {
      success: true,
      query: query,
      count: products.size,
      products: products.map(&:to_hash)
    }.to_json
  rescue StandardError => e
    status 500
    {
      success: false,
      error: e.message
    }.to_json
  end
end

# ===== ROTAS AUXILIARES =====

# Reset do banco (apenas para desenvolvimento!)
post '/reset' do
  begin
    Database.reset!
    Database.seed

    {
      success: true,
      message: 'Banco de dados resetado e populado com dados de exemplo'
    }.to_json
  rescue StandardError => e
    status 500
    {
      success: false,
      error: e.message
    }.to_json
  end
end

# Rota 404 - Não encontrado
not_found do
  {
    success: false,
    error: 'Endpoint não encontrado',
    path: request.path
  }.to_json
end

# Handler de erros
error do
  {
    success: false,
    error: 'Erro interno do servidor'
  }.to_json
end
