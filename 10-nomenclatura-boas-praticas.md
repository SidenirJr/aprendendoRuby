# 📋 Nomenclatura e Boas Práticas em Ruby

## Introdução

Ruby tem convenções bem estabelecidas que tornam o código mais legível e idiomático. Seguir essas práticas é essencial para escrever código Ruby de qualidade.

## 1. Convenções de Nomenclatura

### Variáveis e Métodos - snake_case

Use letras minúsculas com underscores:

```ruby
# ✅ Correto
nome_completo = "João Silva"
idade_usuario = 30

def calcular_total_com_desconto
  # código
end

def enviar_email
  # código
end

# ❌ Incorreto
nomeCompleto = "João Silva"      # camelCase
IdadeUsuario = 30                # PascalCase

def CalcularTotal                # PascalCase
end

def enviarEmail                  # camelCase
end
```

### Classes e Módulos - PascalCase

Use a primeira letra de cada palavra em maiúscula:

```ruby
# ✅ Correto
class Usuario
end

class ContaBancaria
end

module ServicoEmail
end

# ❌ Incorreto
class usuario                    # minúscula
end

class conta_bancaria            # snake_case
end
```

### Constantes - SCREAMING_SNAKE_CASE

Use todas as letras maiúsculas:

```ruby
# ✅ Correto
PI = 3.14159
MAX_TENTATIVAS = 3
TIMEOUT_SEGUNDOS = 30
VERSAO_API = "1.0.0"

# ❌ Incorreto
pi = 3.14159                    # minúscula
MaxTentativas = 3               # PascalCase
timeout_segundos = 30           # snake_case
```

### Variáveis de Instância e Classe

```ruby
class Exemplo
  # Variável de instância - inicia com @
  def initialize
    @nome = "João"
    @idade = 30
  end

  # Variável de classe - inicia com @@
  @@contador = 0

  # Constante
  VERSAO = "1.0"
end
```

### Variáveis Globais - Evite!

```ruby
# ⚠️ Use apenas quando absolutamente necessário
$variavel_global = "valor"

# ✅ Prefira constantes ou passagem de parâmetros
CONFIGURACAO = "valor"
```

### Métodos Booleanos - sufixo ?

Métodos que retornam true/false devem terminar com `?`:

```ruby
# ✅ Correto
def par?(numero)
  numero.even?
end

def vazio?
  @items.empty?
end

def ativo?
  @status == :ativo
end

# ❌ Incorreto
def eh_par(numero)             # Não use 'eh_' ou 'is_'
end

def verificar_vazio            # Não termine sem ?
end
```

### Métodos Destrutivos - sufixo !

Métodos que modificam o objeto original devem terminar com `!`:

```ruby
# ✅ Correto
def ordenar!
  @items.sort!
end

def limpar!
  @cache.clear
end

# Sempre tenha versão sem ! também
def ordenar
  @items.sort
end

# ❌ Incorreto - não use ! se não modifica o objeto
def calcular_total!            # Não modifica objeto
  @items.sum
end
```

### Nomes de Arquivos

```ruby
# Use snake_case
usuario.rb
conta_bancaria.rb
servico_email.rb

# Organize por funcionalidade
app/
  models/
    usuario.rb
    produto.rb
  controllers/
    usuarios_controller.rb
  services/
    email_service.rb
```

## 2. Indentação e Formatação

### Indentação - 2 Espaços

```ruby
# ✅ Correto - 2 espaços
class Usuario
  def initialize(nome)
    @nome = nome
    if @nome.empty?
      raise "Nome não pode ser vazio"
    end
  end
end

# ❌ Incorreto - 4 espaços ou tabs
class Usuario
    def initialize(nome)
        @nome = nome
    end
end
```

### Limite de Linhas

Mantenha linhas com no máximo 80-120 caracteres:

```ruby
# ✅ Correto
def processar_usuario(nome, idade, email, telefone)
  Usuario.create(
    nome: nome,
    idade: idade,
    email: email,
    telefone: telefone
  )
end

# ❌ Incorreto - linha muito longa
def processar_usuario(nome, idade, email, telefone)
  Usuario.create(nome: nome, idade: idade, email: email, telefone: telefone, ativo: true, verificado: false)
end
```

### Espaços

```ruby
# ✅ Correto - espaços ao redor de operadores
a = 1 + 2
resultado = valor * 2

# Após vírgulas
array = [1, 2, 3, 4]
hash = { nome: "João", idade: 30 }

# Não dentro de parênteses/colchetes/chaves
metodo(parametro)
[1, 2, 3]
{ chave: valor }

# ❌ Incorreto
a=1+2                          # Sem espaços
array = [ 1,2,3,4 ]            # Espaços errados
metodo( parametro )            # Espaço desnecessário
```

### Linhas em Branco

```ruby
# ✅ Correto - organize com linhas em branco
class Usuario
  attr_accessor :nome, :email

  def initialize(nome)
    @nome = nome
  end

  def validar
    return false if @nome.empty?
    true
  end

  def salvar
    validar ? persisir : false
  end

  private

  def persistir
    # código
  end
end

# ❌ Incorreto - sem organização
class Usuario
  attr_accessor :nome, :email
  def initialize(nome)
    @nome = nome
  end
  def validar
    return false if @nome.empty?
    true
  end
end
```

## 3. Estilo de Código

### Blocos - { } vs do...end

```ruby
# ✅ Use { } para blocos de uma linha
[1, 2, 3].map { |n| n * 2 }
usuarios.select { |u| u.ativo? }

# ✅ Use do...end para blocos multi-linha
usuarios.each do |usuario|
  usuario.processar
  usuario.notificar
end

# ❌ Incorreto
[1, 2, 3].map do |n| n * 2 end  # do...end em uma linha

usuarios.each { |u|
  u.processar
  u.notificar
}                                # { } multi-linha
```

### Condicionais

```ruby
# ✅ Use modificadores para condições simples
return unless usuario.valido?
enviar_email if usuario.ativo?

# ✅ Use if/else para lógica complexa
if usuario.valido? && usuario.ativo?
  processar_usuario(usuario)
else
  registrar_erro(usuario)
end

# ❌ Evite unless com else
unless usuario.invalido?
  processar
else
  erro
end

# ✅ Prefira if neste caso
if usuario.valido?
  processar
else
  erro
end

# ✅ Guard clauses para reduzir aninhamento
def processar_pedido(pedido)
  return unless pedido
  return unless pedido.valido?
  return unless pedido.pago?

  # processar
end

# ❌ Muito aninhamento
def processar_pedido(pedido)
  if pedido
    if pedido.valido?
      if pedido.pago?
        # processar
      end
    end
  end
end
```

### Strings

```ruby
# ✅ Use aspas duplas para interpolação
nome = "João"
mensagem = "Olá, #{nome}!"

# ✅ Use aspas simples para strings literais
literal = 'Texto sem interpolação'

# ✅ Use %w para arrays de strings
palavras = %w[ruby python javascript]
# => ["ruby", "python", "javascript"]

# ✅ Use heredoc para textos longos
email_body = <<~TEXTO
  Olá #{nome},

  Bem-vindo ao nosso sistema!

  Atenciosamente,
  Equipe
TEXTO
```

### Hashes

```ruby
# ✅ Use sintaxe moderna com símbolos
pessoa = {
  nome: "João",
  idade: 30,
  cidade: "SP"
}

# ❌ Sintaxe antiga (evite)
pessoa = {
  :nome => "João",
  :idade => 30
}

# ✅ Use => apenas para chaves que não são símbolos
hash = {
  "string" => "valor",
  1 => "número"
}
```

## 4. Boas Práticas de Código

### Métodos Pequenos e Focados

```ruby
# ✅ Métodos fazem uma coisa
class Usuario
  def validar
    validar_nome && validar_email && validar_idade
  end

  private

  def validar_nome
    !@nome.empty?
  end

  def validar_email
    @email.include?('@')
  end

  def validar_idade
    @idade >= 18
  end
end

# ❌ Método faz muitas coisas
def processar_tudo
  validar_nome
  validar_email
  salvar_banco
  enviar_email
  registrar_log
  atualizar_cache
  notificar_admin
end
```

### DRY - Don't Repeat Yourself

```ruby
# ❌ Código repetido
def area_retangulo(largura, altura)
  largura * altura
end

def area_quadrado(lado)
  lado * lado
end

def area_triangulo(base, altura)
  (base * altura) / 2.0
end

# ✅ Extrair lógica comum
class CalculadoraArea
  def self.retangulo(largura, altura)
    largura * altura
  end

  def self.quadrado(lado)
    retangulo(lado, lado)
  end

  def self.triangulo(base, altura)
    retangulo(base, altura) / 2.0
  end
end
```

### Retorno Explícito vs Implícito

```ruby
# ✅ Retorno implícito (idiomático)
def somar(a, b)
  a + b
end

# ✅ Return explícito para sair cedo
def processar(valor)
  return nil unless valor
  return nil if valor < 0

  valor * 2
end

# ❌ Return desnecessário no final
def somar(a, b)
  return a + b  # Desnecessário
end
```

### Evite Mutações Inesperadas

```ruby
# ❌ Modifica argumento
def processar_nome(nome)
  nome.upcase!  # Modifica o original
end

# ✅ Retorna novo valor
def processar_nome(nome)
  nome.upcase
end

# ✅ Se precisa modificar, deixe claro com !
def processar_nome!(nome)
  nome.upcase!
end
```

### Use Enumeradores Apropriados

```ruby
# ❌ Loop manual
resultado = []
for i in 0...array.length
  resultado << array[i] * 2
end

# ✅ Use map
resultado = array.map { |n| n * 2 }

# ❌ each com acumulador
soma = 0
numeros.each { |n| soma += n }

# ✅ Use reduce
soma = numeros.reduce(0, :+)
# ou
soma = numeros.sum
```

## 5. Organização de Classes

```ruby
# ✅ Ordem recomendada
class Usuario
  # 1. Extends e includes
  include Comparable

  # 2. Constantes
  MAX_TENTATIVAS = 3

  # 3. attr_accessor/reader/writer
  attr_accessor :nome, :email
  attr_reader :id

  # 4. Métodos de classe
  def self.criar(params)
    new(params)
  end

  # 5. Initialize
  def initialize(params)
    @nome = params[:nome]
    @email = params[:email]
  end

  # 6. Métodos públicos
  def validar
    validar_nome && validar_email
  end

  def salvar
    return false unless validar
    persistir
  end

  # 7. Protected
  protected

  def pode_acessar?(outro_usuario)
    outro_usuario.id == @id
  end

  # 8. Private
  private

  def validar_nome
    !@nome.empty?
  end

  def validar_email
    @email.include?('@')
  end

  def persistir
    # código
  end
end
```

## 6. Comentários e Documentação

```ruby
# ✅ Comentários explicam "por quê", não "o quê"
# Usamos 3 tentativas porque o servidor é instável
MAX_TENTATIVAS = 3

# ❌ Comentário óbvio
# Define a variável x como 5
x = 5

# ✅ Documente métodos públicos complexos
# Processa pagamento com retry automático
#
# @param valor [Float] Valor a ser processado
# @param tentativas [Integer] Número de tentativas
# @return [Boolean] True se processado com sucesso
def processar_pagamento(valor, tentativas: 3)
  # implementação
end

# ✅ TODO para código futuro
def calcular_desconto
  # TODO: Implementar desconto para clientes VIP
  preco * 0.9
end
```

## 7. Tratamento de Erros

```ruby
# ✅ Use exceções específicas
def dividir(a, b)
  raise ArgumentError, "Divisor não pode ser zero" if b.zero?
  a / b
end

# ✅ Rescue específico
begin
  arquivo = File.open("dados.txt")
rescue Errno::ENOENT => e
  puts "Arquivo não encontrado: #{e.message}"
rescue => e
  puts "Erro inesperado: #{e.message}"
ensure
  arquivo&.close
end

# ❌ Rescue genérico sem reraiser
begin
  codigo_perigoso
rescue
  # Engolir erro silenciosamente é ruim
end
```

## 8. Gems Úteis para Qualidade de Código

```ruby
# Gemfile

# Análise estática de código
gem 'rubocop', require: false

# Testes
gem 'rspec'
gem 'minitest'

# Debugging
gem 'pry'
gem 'byebug'

# Performance
gem 'benchmark-ips'

# Documentação
gem 'yard'
```

## 9. Checklist de Boas Práticas

### Nomenclatura
- [ ] Variáveis e métodos em snake_case
- [ ] Classes e módulos em PascalCase
- [ ] Constantes em SCREAMING_SNAKE_CASE
- [ ] Métodos booleanos terminam com ?
- [ ] Métodos destrutivos terminam com !

### Formatação
- [ ] Indentação de 2 espaços
- [ ] Linhas com máximo 80-120 caracteres
- [ ] Espaços ao redor de operadores
- [ ] Linhas em branco entre métodos

### Estilo
- [ ] { } para blocos de uma linha
- [ ] do...end para blocos multi-linha
- [ ] Guard clauses para reduzir aninhamento
- [ ] Aspas duplas para interpolação

### Código
- [ ] Métodos pequenos (< 15 linhas)
- [ ] Métodos fazem uma coisa
- [ ] DRY - não repetir código
- [ ] Retorno implícito quando possível
- [ ] Comentários explicam "por quê"

## 10. Exemplo Completo Seguindo Boas Práticas

```ruby
# frozen_string_literal: true

# Representa um produto no sistema de e-commerce
class Produto
  include Comparable

  CATEGORIAS_VALIDAS = %w[eletronicos livros roupas].freeze
  DESCONTO_MAXIMO = 0.5

  attr_reader :id, :nome, :categoria
  attr_accessor :preco

  def initialize(id:, nome:, preco:, categoria:)
    @id = id
    @nome = nome
    @preco = preco
    @categoria = categoria
    validar!
  end

  def aplicar_desconto(percentual)
    validar_percentual_desconto(percentual)
    @preco *= (1 - percentual)
  end

  def em_promocao?
    @preco < preco_original * 0.8
  end

  def <=>(outro)
    preco <=> outro.preco
  end

  def to_s
    "#{nome} - R$ #{preco.round(2)}"
  end

  private

  def validar!
    validar_nome
    validar_preco
    validar_categoria
  end

  def validar_nome
    raise ArgumentError, 'Nome não pode ser vazio' if nome.empty?
  end

  def validar_preco
    raise ArgumentError, 'Preço deve ser positivo' unless preco.positive?
  end

  def validar_categoria
    return if CATEGORIAS_VALIDAS.include?(categoria)

    raise ArgumentError, "Categoria inválida: #{categoria}"
  end

  def validar_percentual_desconto(percentual)
    if percentual < 0 || percentual > DESCONTO_MAXIMO
      raise ArgumentError, 'Desconto inválido'
    end
  end

  def preco_original
    @preco_original ||= @preco
  end
end
```

## Resumo

✅ **Nomenclatura**: snake_case, PascalCase, SCREAMING_SNAKE_CASE
✅ **Indentação**: 2 espaços, sem tabs
✅ **Blocos**: { } uma linha, do...end multi-linha
✅ **Métodos**: Pequenos, focados, nomes descritivos
✅ **DRY**: Não repita código
✅ **Guard Clauses**: Reduza aninhamento
✅ **Comentários**: Explique o "por quê"
✅ **Exceções**: Use específicas, trate adequadamente
✅ **Testes**: Sempre escreva testes

## Recursos

- [Ruby Style Guide](https://rubystyle.guide/)
- [RuboCop](https://github.com/rubocop/rubocop)
- [The Ruby Way](https://therubyway.io/)

---

**Parabéns por concluir o guia completo de Ruby! Continue praticando e escrevendo código limpo e idiomático!** 💎

---

[⬅️ Anterior: Blocos, Procs e Lambdas](09-blocos-procs-lambdas.md) | [🏠 Voltar ao Índice](README.md)
