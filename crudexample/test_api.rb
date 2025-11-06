#!/usr/bin/env ruby
# frozen_string_literal: true

require 'httparty'
require 'json'

# Script de teste para a API de Produtos
class APITester
  BASE_URL = 'http://localhost:4567'

  def initialize
    @headers = { 'Content-Type' => 'application/json' }
  end

  def run
    puts "=" * 60
    puts "🧪 TESTANDO API DE PRODUTOS"
    puts "=" * 60
    puts

    check_server
    test_root
    test_reset
    test_list_products
    test_create_product
    test_get_product
    test_update_product
    test_search
    test_delete_product

    puts
    puts "=" * 60
    puts "✅ TODOS OS TESTES CONCLUÍDOS!"
    puts "=" * 60
  end

  private

  def check_server
    puts "🔍 Verificando se o servidor está rodando..."
    response = HTTParty.get("#{BASE_URL}/")

    if response.success?
      puts "✅ Servidor está rodando!\n"
    else
      puts "❌ Servidor não está respondendo!"
      puts "Execute: ruby app.rb"
      exit 1
    end
  rescue StandardError => e
    puts "❌ Erro ao conectar ao servidor: #{e.message}"
    puts "Certifique-se de que o servidor está rodando: ruby app.rb"
    exit 1
  end

  def test_root
    section("Testando GET /")

    response = HTTParty.get("#{BASE_URL}/")
    print_response(response)

    assert(response.success?, "Deve retornar sucesso")
    assert(response.parsed_response['message'], "Deve ter mensagem")
  end

  def test_reset
    section("Testando POST /reset - Resetar banco de dados")

    response = HTTParty.post("#{BASE_URL}/reset", headers: @headers)
    print_response(response)

    assert(response.success?, "Deve resetar com sucesso")
    assert(response.parsed_response['success'], "success deve ser true")
  end

  def test_list_products
    section("Testando GET /products - Listar produtos")

    response = HTTParty.get("#{BASE_URL}/products")
    print_response(response)

    assert(response.success?, "Deve retornar sucesso")
    assert(response.parsed_response['products'].is_a?(Array), "Deve retornar array de produtos")
    assert(response.parsed_response['products'].size > 0, "Deve ter produtos")
  end

  def test_create_product
    section("Testando POST /products - Criar produto")

    new_product = {
      name: "Produto de Teste",
      description: "Criado pelo script de teste",
      price: 99.90,
      quantity: 100
    }

    response = HTTParty.post(
      "#{BASE_URL}/products",
      headers: @headers,
      body: new_product.to_json
    )
    print_response(response)

    assert(response.code == 201, "Deve retornar status 201")
    assert(response.parsed_response['success'], "success deve ser true")
    assert(response.parsed_response['product']['id'], "Deve retornar produto com ID")

    @created_product_id = response.parsed_response['product']['id']

    # Teste de validação - produto inválido
    subsection("Testando validação - produto sem nome")

    invalid_product = { price: 50 }
    response = HTTParty.post(
      "#{BASE_URL}/products",
      headers: @headers,
      body: invalid_product.to_json
    )

    assert(response.code == 422, "Deve retornar status 422 para dados inválidos")
    assert(response.parsed_response['errors'], "Deve retornar erros de validação")
  end

  def test_get_product
    section("Testando GET /products/:id - Buscar produto específico")

    response = HTTParty.get("#{BASE_URL}/products/1")
    print_response(response)

    assert(response.success?, "Deve retornar sucesso")
    assert(response.parsed_response['product'], "Deve retornar produto")
    assert(response.parsed_response['product']['id'] == 1, "Deve retornar produto correto")

    # Teste de produto não encontrado
    subsection("Testando produto não encontrado")

    response = HTTParty.get("#{BASE_URL}/products/99999")
    print_response(response)

    assert(response.code == 404, "Deve retornar status 404")
    assert(response.parsed_response['error'], "Deve retornar mensagem de erro")
  end

  def test_update_product
    section("Testando PUT /products/:id - Atualizar produto")

    update_data = {
      name: "Produto Atualizado",
      price: 149.90
    }

    response = HTTParty.put(
      "#{BASE_URL}/products/1",
      headers: @headers,
      body: update_data.to_json
    )
    print_response(response)

    assert(response.success?, "Deve retornar sucesso")
    assert(response.parsed_response['product']['name'] == "Produto Atualizado", "Deve atualizar o nome")
    assert(response.parsed_response['product']['price'] == 149.90, "Deve atualizar o preço")
  end

  def test_search
    section("Testando GET /search?q=termo - Buscar produtos")

    response = HTTParty.get("#{BASE_URL}/search?q=notebook")
    print_response(response)

    assert(response.success?, "Deve retornar sucesso")
    assert(response.parsed_response['products'].is_a?(Array), "Deve retornar array")
    assert(response.parsed_response['query'] == "notebook", "Deve retornar query buscada")
  end

  def test_delete_product
    section("Testando DELETE /products/:id - Deletar produto")

    # Usar o produto criado no teste anterior
    product_id = @created_product_id || 2

    response = HTTParty.delete("#{BASE_URL}/products/#{product_id}")
    print_response(response)

    assert(response.success?, "Deve retornar sucesso")
    assert(response.parsed_response['success'], "success deve ser true")

    # Verificar se foi realmente deletado
    subsection("Verificando se produto foi deletado")

    response = HTTParty.get("#{BASE_URL}/products/#{product_id}")
    assert(response.code == 404, "Produto deletado não deve ser encontrado")
  end

  # Helpers

  def section(title)
    puts
    puts "-" * 60
    puts "📋 #{title}"
    puts "-" * 60
  end

  def subsection(title)
    puts
    puts "  📌 #{title}"
  end

  def print_response(response)
    puts "  Status: #{response.code}"

    begin
      body = JSON.pretty_generate(response.parsed_response)
      puts "  Body:"
      body.lines.each { |line| puts "    #{line}" }
    rescue StandardError
      puts "  Body: #{response.body}"
    end
  end

  def assert(condition, message)
    if condition
      puts "  ✅ #{message}"
    else
      puts "  ❌ FALHOU: #{message}"
      @failed = true
    end
  end
end

# Executar testes
if __FILE__ == $PROGRAM_NAME
  tester = APITester.new
  tester.run
end
