# 🛍️ CRUD RESTful API com Ruby, Sinatra e SQLite

API RESTful completa para gerenciamento de produtos usando Ruby, Sinatra e SQLite3.

## 📋 Características

- ✅ CRUD completo (Create, Read, Update, Delete)
- ✅ API RESTful seguindo boas práticas
- ✅ SQLite como banco de dados
- ✅ Validações de dados
- ✅ Busca de produtos
- ✅ Respostas em JSON
- ✅ Tratamento de erros
- ✅ Códigos HTTP apropriados

## 🗂️ Estrutura do Projeto

```
crudexample/
├── app.rb                  # API RESTful (Sinatra)
├── Gemfile                 # Dependências
├── config/
│   └── database.rb         # Configuração do SQLite
├── models/
│   └── product.rb          # Model Product
├── test_api.rb             # Script de teste
└── products.db             # Banco SQLite (criado automaticamente)
```

## 🚀 Instalação e Execução

### 1. Instalar Dependências

```bash
cd crudexample
bundle install
```

Se não tiver o Bundler instalado:
```bash
gem install bundler
bundle install
```

### 2. Iniciar o Servidor

```bash
ruby app.rb
```

Ou com auto-reload durante desenvolvimento:
```bash
rerun ruby app.rb
```

O servidor estará rodando em: **http://localhost:4567**

### 3. Popular com Dados de Exemplo

```bash
curl -X POST http://localhost:4567/reset
```

## 📚 Documentação da API

### Base URL
```
http://localhost:4567
```

### Endpoints

#### 1. Informações da API
```http
GET /
```

**Resposta:**
```json
{
  "message": "API de Produtos - CRUD RESTful",
  "version": "1.0.0",
  "endpoints": { ... },
  "total_products": 5
}
```

---

#### 2. Listar Todos os Produtos
```http
GET /products
```

**Resposta:**
```json
{
  "success": true,
  "count": 5,
  "products": [
    {
      "id": 1,
      "name": "Notebook Dell",
      "description": "Notebook Dell Inspiron 15",
      "price": 3500.0,
      "quantity": 10,
      "created_at": "2025-11-06 20:00:00",
      "updated_at": "2025-11-06 20:00:00"
    }
  ]
}
```

**Exemplo cURL:**
```bash
curl http://localhost:4567/products
```

---

#### 3. Buscar Produto por ID
```http
GET /products/:id
```

**Resposta de Sucesso (200):**
```json
{
  "success": true,
  "product": {
    "id": 1,
    "name": "Notebook Dell",
    "description": "Notebook Dell Inspiron 15",
    "price": 3500.0,
    "quantity": 10,
    "created_at": "2025-11-06 20:00:00",
    "updated_at": "2025-11-06 20:00:00"
  }
}
```

**Resposta de Erro (404):**
```json
{
  "success": false,
  "error": "Produto não encontrado"
}
```

**Exemplo cURL:**
```bash
curl http://localhost:4567/products/1
```

---

#### 4. Criar Novo Produto
```http
POST /products
Content-Type: application/json
```

**Body:**
```json
{
  "name": "Teclado Mecânico",
  "description": "Teclado RGB com switches blue",
  "price": 450.00,
  "quantity": 25
}
```

**Resposta de Sucesso (201):**
```json
{
  "success": true,
  "message": "Produto criado com sucesso",
  "product": {
    "id": 6,
    "name": "Teclado Mecânico",
    "description": "Teclado RGB com switches blue",
    "price": 450.0,
    "quantity": 25,
    "created_at": "2025-11-06 20:05:00",
    "updated_at": "2025-11-06 20:05:00"
  }
}
```

**Resposta de Erro (422):**
```json
{
  "success": false,
  "errors": ["Nome é obrigatório", "Preço deve ser positivo"]
}
```

**Exemplo cURL:**
```bash
curl -X POST http://localhost:4567/products \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Teclado Mecânico",
    "description": "Teclado RGB",
    "price": 450.00,
    "quantity": 25
  }'
```

---

#### 5. Atualizar Produto
```http
PUT /products/:id
Content-Type: application/json
```

**Body:**
```json
{
  "name": "Notebook Dell Atualizado",
  "price": 3200.00,
  "quantity": 15
}
```

**Resposta de Sucesso (200):**
```json
{
  "success": true,
  "message": "Produto atualizado com sucesso",
  "product": {
    "id": 1,
    "name": "Notebook Dell Atualizado",
    "description": "Notebook Dell Inspiron 15",
    "price": 3200.0,
    "quantity": 15,
    "created_at": "2025-11-06 20:00:00",
    "updated_at": "2025-11-06 20:10:00"
  }
}
```

**Exemplo cURL:**
```bash
curl -X PUT http://localhost:4567/products/1 \
  -H "Content-Type: application/json" \
  -d '{
    "price": 3200.00,
    "quantity": 15
  }'
```

---

#### 6. Deletar Produto
```http
DELETE /products/:id
```

**Resposta de Sucesso (200):**
```json
{
  "success": true,
  "message": "Produto deletado com sucesso"
}
```

**Resposta de Erro (404):**
```json
{
  "success": false,
  "error": "Produto não encontrado"
}
```

**Exemplo cURL:**
```bash
curl -X DELETE http://localhost:4567/products/1
```

---

#### 7. Buscar Produtos
```http
GET /search?q=termo
```

**Resposta:**
```json
{
  "success": true,
  "query": "notebook",
  "count": 1,
  "products": [
    {
      "id": 1,
      "name": "Notebook Dell",
      "description": "Notebook Dell Inspiron 15",
      "price": 3500.0,
      "quantity": 10,
      "created_at": "2025-11-06 20:00:00",
      "updated_at": "2025-11-06 20:00:00"
    }
  ]
}
```

**Exemplo cURL:**
```bash
curl http://localhost:4567/search?q=notebook
```

---

#### 8. Resetar Banco (Desenvolvimento)
```http
POST /reset
```

**Resposta:**
```json
{
  "success": true,
  "message": "Banco de dados resetado e populado com dados de exemplo"
}
```

**Exemplo cURL:**
```bash
curl -X POST http://localhost:4567/reset
```

## 📊 Códigos de Status HTTP

| Código | Descrição |
|--------|-----------|
| 200 | OK - Requisição bem-sucedida |
| 201 | Created - Recurso criado com sucesso |
| 400 | Bad Request - Parâmetros inválidos |
| 404 | Not Found - Recurso não encontrado |
| 422 | Unprocessable Entity - Validação falhou |
| 500 | Internal Server Error - Erro no servidor |

## 🧪 Testando a API

### Usando o Script de Teste

```bash
ruby test_api.rb
```

### Usando cURL

```bash
# Listar produtos
curl http://localhost:4567/products

# Criar produto
curl -X POST http://localhost:4567/products \
  -H "Content-Type: application/json" \
  -d '{"name": "Mouse", "price": 89.90, "quantity": 50}'

# Buscar produto
curl http://localhost:4567/products/1

# Atualizar produto
curl -X PUT http://localhost:4567/products/1 \
  -H "Content-Type: application/json" \
  -d '{"price": 79.90}'

# Deletar produto
curl -X DELETE http://localhost:4567/products/1

# Buscar
curl http://localhost:4567/search?q=mouse
```

### Usando HTTPie (mais legível)

```bash
# Instalar HTTPie: pip install httpie

# Listar produtos
http GET http://localhost:4567/products

# Criar produto
http POST http://localhost:4567/products \
  name="Mouse" price:=89.90 quantity:=50

# Buscar produto
http GET http://localhost:4567/products/1

# Atualizar produto
http PUT http://localhost:4567/products/1 price:=79.90

# Deletar produto
http DELETE http://localhost:4567/products/1
```

### Usando Postman

1. Importe a coleção de requests
2. Configure a base URL: `http://localhost:4567`
3. Teste todos os endpoints

## 🗃️ Modelo de Dados

### Tabela: products

| Campo | Tipo | Descrição |
|-------|------|-----------|
| id | INTEGER | Chave primária (auto-incremento) |
| name | TEXT | Nome do produto (obrigatório) |
| description | TEXT | Descrição do produto |
| price | REAL | Preço (obrigatório, > 0) |
| quantity | INTEGER | Quantidade em estoque (≥ 0) |
| created_at | DATETIME | Data de criação |
| updated_at | DATETIME | Data da última atualização |

## 🔍 Validações

- **name**: Obrigatório, não pode ser vazio
- **price**: Obrigatório, deve ser maior que 0
- **quantity**: Deve ser maior ou igual a 0 (padrão: 0)

## 🛠️ Tecnologias Utilizadas

- **Ruby** - Linguagem de programação
- **Sinatra** - Framework web minimalista
- **SQLite3** - Banco de dados SQL embutido
- **JSON** - Formato de dados
- **Puma** - Servidor web

## 📁 Arquivos Principais

### app.rb
Aplicação Sinatra com todas as rotas RESTful.

### config/database.rb
Configuração e gerenciamento do banco SQLite.

### models/product.rb
Model com todas as operações CRUD e validações.

## 🎯 Próximos Passos / Melhorias

- [ ] Adicionar autenticação (JWT)
- [ ] Implementar paginação
- [ ] Adicionar mais filtros de busca
- [ ] Criar testes automatizados (RSpec)
- [ ] Documentação com Swagger/OpenAPI
- [ ] Rate limiting
- [ ] Logging estruturado
- [ ] Docker container

## 📝 Notas

- O banco de dados SQLite é criado automaticamente no primeiro acesso
- Para desenvolvimento, use `rerun ruby app.rb` para auto-reload
- Em produção, considere usar PostgreSQL ou MySQL
- O endpoint `/reset` deve ser removido em produção

## 🤝 Contribuindo

Sinta-se livre para melhorar este exemplo! Sugestões:

1. Fork o repositório
2. Crie uma branch para sua feature
3. Commit suas mudanças
4. Push para a branch
5. Abra um Pull Request

## 📄 Licença

Este é um projeto educacional de exemplo.

---

**Desenvolvido com ❤️ usando Ruby**

[🏠 Voltar ao Índice Principal](../README.md)
