# 📦 Variáveis e Tipos de Dados em Ruby

## O que são Variáveis?

Variáveis são "caixas" que armazenam valores para uso posterior no programa. Em Ruby, as variáveis têm **tipagem dinâmica**, ou seja, não é necessário declarar o tipo da variável.

## Tipos de Variáveis em Ruby

Ruby possui 4 tipos principais de variáveis, identificados pelo primeiro caractere:

### 1. Variáveis Locais

Começam com letra minúscula ou underscore `_`:

```ruby
nome = "Maria"
idade = 25
_temporario = "valor"
resultado_final = 100
```

**Características:**
- Escopo limitado ao bloco/método onde foram definidas
- Mais comuns no dia a dia
- Convenção: usar snake_case

```ruby
def exemplo
  variavel_local = "Só existe aqui dentro"
  puts variavel_local
end

exemplo
# puts variavel_local  # Erro! Variável não existe fora do método
```

### 2. Variáveis de Instância

Começam com `@`:

```ruby
class Pessoa
  def initialize(nome)
    @nome = nome  # Variável de instância
  end

  def apresentar
    puts "Meu nome é #{@nome}"
  end
end

pessoa = Pessoa.new("João")
pessoa.apresentar  # => Meu nome é João
```

**Características:**
- Pertencem a uma instância específica de uma classe
- Acessíveis em todos os métodos da instância
- Cada objeto tem suas próprias variáveis de instância

### 3. Variáveis de Classe

Começam com `@@`:

```ruby
class Contador
  @@total = 0  # Variável de classe

  def initialize
    @@total += 1
  end

  def self.total
    @@total
  end
end

c1 = Contador.new
c2 = Contador.new
c3 = Contador.new

puts Contador.total  # => 3
```

**Características:**
- Compartilhadas entre todas as instâncias da classe
- Pertencem à classe, não aos objetos individuais
- Uso menos comum (considere usar constantes ou variáveis de classe próprias)

### 4. Variáveis Globais

Começam com `$`:

```ruby
$variavel_global = "Acessível em todo lugar"

def metodo_qualquer
  puts $variavel_global
end

class MinhaClasse
  def outro_metodo
    puts $variavel_global
  end
end

metodo_qualquer
MinhaClasse.new.outro_metodo
```

**Características:**
- Acessíveis de qualquer lugar do programa
- ⚠️ **Evite usar!** Podem causar problemas difíceis de debugar
- Quebram encapsulamento

### 5. Constantes

Começam com letra MAIÚSCULA (convenção: todas maiúsculas com underscore):

```ruby
PI = 3.14159
NOME_APLICACAO = "Meu App"
VERSION = "1.0.0"

class Configuracao
  MAX_TENTATIVAS = 3
  TIMEOUT = 30
end

puts PI
puts Configuracao::MAX_TENTATIVAS
```

**Características:**
- Não devem ser modificadas (Ruby emite warning se modificadas)
- Convenção: TODAS_MAIUSCULAS
- Escopo pode ser global ou dentro de classes/módulos

```ruby
CONSTANTE = 10
CONSTANTE = 20  # warning: already initialized constant CONSTANTE
```

## Tipos de Dados Primitivos

### 1. Números (Numbers)

#### Inteiros (Integer)

```ruby
# Inteiros positivos e negativos
numero = 42
negativo = -10
grande = 1_000_000  # Underscores facilitam leitura

puts numero.class  # => Integer
```

#### Ponto Flutuante (Float)

```ruby
pi = 3.14159
temperatura = -5.5
cientifico = 1.5e3  # 1.5 * 10^3 = 1500.0

puts pi.class  # => Float
```

#### Operações com números

```ruby
# Ruby automaticamente converte tipos quando necessário
10 / 3        # => 3 (divisão inteira)
10.0 / 3      # => 3.333... (divisão com float)
10 / 3.0      # => 3.333... (divisão com float)

# Métodos úteis
42.even?      # => true
42.odd?       # => false
-5.abs        # => 5 (valor absoluto)
4.5.round     # => 5 (arredonda)
4.5.floor     # => 4 (arredonda para baixo)
4.5.ceil      # => 5 (arredonda para cima)
```

### 2. Strings (Texto)

```ruby
# Strings com aspas duplas (permitem interpolação)
nome = "Maria"
mensagem = "Olá, #{nome}!"

# Strings com aspas simples (não permitem interpolação)
literal = 'Texto #{nome}'  # => "Texto #{nome}"

# Strings multi-linha
texto_longo = <<~HEREDOC
  Este é um texto
  com múltiplas linhas
  muito útil para textos longos
HEREDOC
```

#### Métodos de String

```ruby
texto = "Ruby é incrível"

# Tamanho
texto.length          # => 15
texto.size            # => 15 (mesmo que length)

# Transformações
texto.upcase          # => "RUBY É INCRÍVEL"
texto.downcase        # => "ruby é incrível"
texto.capitalize      # => "Ruby é incrível"
texto.reverse         # => "levírcni é ybuR"

# Verificações
texto.include?("Ruby")     # => true
texto.start_with?("Ruby")  # => true
texto.end_with?("vel")     # => true
texto.empty?               # => false

# Substituição
texto.gsub("Ruby", "Python")  # => "Python é incrível"

# Divisão
"a,b,c".split(",")  # => ["a", "b", "c"]

# Remoção de espaços
"  texto  ".strip   # => "texto"
"  texto  ".lstrip  # => "texto  "
"  texto  ".rstrip  # => "  texto"
```

#### Concatenação de Strings

```ruby
# Usando +
"Hello" + " " + "World"  # => "Hello World"

# Usando <<
str = "Hello"
str << " World"  # Modifica str
puts str  # => "Hello World"

# Usando interpolação (preferível)
nome = "João"
"Olá, #{nome}!"  # => "Olá, João!"

# Multiplicação
"Ruby" * 3  # => "RubyRubyRuby"
```

### 3. Símbolos (Symbols)

Símbolos são como strings imutáveis e mais eficientes em termos de memória:

```ruby
# Símbolos começam com :
:nome
:idade
:usuario_ativo

# Por que usar símbolos?
# 1. Mais eficientes (mesmo símbolo = mesmo objeto na memória)
:nome.object_id == :nome.object_id  # => true
"nome".object_id == "nome".object_id  # => false

# 2. Usados comumente como chaves em hashes
pessoa = {
  nome: "Maria",      # :nome é um símbolo
  idade: 25,
  cidade: "São Paulo"
}

# 3. Usados em métodos como identificadores
attr_accessor :nome, :idade
```

**String vs Symbol:**

```ruby
# Strings - mutáveis, cada uma é um objeto diferente
s1 = "texto"
s2 = "texto"
s1.object_id == s2.object_id  # => false

# Symbols - imutáveis, mesmo símbolo = mesmo objeto
:texto.object_id == :texto.object_id  # => true

# Conversão
:simbolo.to_s   # => "simbolo" (Symbol para String)
"texto".to_sym  # => :texto (String para Symbol)
```

### 4. Booleanos (Boolean)

Ruby tem dois valores booleanos:

```ruby
verdadeiro = true
falso = false

puts verdadeiro.class  # => TrueClass
puts falso.class       # => FalseClass
```

**Valores "falsy" e "truthy":**

Em Ruby, apenas `false` e `nil` são considerados falsos. **Tudo o mais** é verdadeiro!

```ruby
# Falsy (avaliados como falso)
nil
false

# Truthy (avaliados como verdadeiro)
true
0           # ⚠️ DIFERENTE de outras linguagens!
""          # String vazia é true
[]          # Array vazio é true
{}          # Hash vazio é true
"false"     # String "false" é true!
```

### 5. Nil (Nulo)

`nil` representa a ausência de valor:

```ruby
variavel = nil
puts variavel.class  # => NilClass

# Verificando nil
variavel.nil?  # => true

# Em condicionais
if variavel
  puts "Não vai executar"
end

if variavel.nil?
  puts "variavel é nil"
end

# Operador de navegação segura
pessoa = nil
pessoa&.nome  # => nil (não gera erro)
# pessoa.nome  # => Erro! (NoMethodError)
```

### 6. Ranges (Intervalos)

Ranges representam sequências:

```ruby
# Range inclusivo (inclui o último número)
1..10     # => 1, 2, 3, 4, 5, 6, 7, 8, 9, 10

# Range exclusivo (exclui o último número)
1...10    # => 1, 2, 3, 4, 5, 6, 7, 8, 9

# Com letras
'a'..'z'

# Métodos úteis
(1..5).to_a           # => [1, 2, 3, 4, 5]
(1..10).include?(5)   # => true
(1..10).min           # => 1
(1..10).max           # => 10

# Em loops
(1..5).each do |n|
  puts n
end
```

## Conversões de Tipo (Type Casting)

```ruby
# Para Integer
"123".to_i        # => 123
"12.5".to_i       # => 12 (trunca)
12.5.to_i         # => 12

# Para Float
"12.5".to_f       # => 12.5
123.to_f          # => 123.0

# Para String
123.to_s          # => "123"
12.5.to_s         # => "12.5"
:simbolo.to_s     # => "simbolo"

# Para Symbol
"texto".to_sym    # => :texto
"texto".intern    # => :texto (mesmo que to_sym)

# Para Array
(1..5).to_a       # => [1, 2, 3, 4, 5]

# Conversão segura com rescue
valor = "abc123"
numero = valor.to_i  # => 0 (conversão inválida retorna 0)

# Integer() é mais rigoroso
Integer("123")    # => 123
Integer("abc")    # => ArgumentError!
```

## Verificando Tipos

```ruby
42.class                  # => Integer
42.is_a?(Integer)        # => true
42.kind_of?(Numeric)     # => true
42.respond_to?(:even?)   # => true

"texto".class            # => String
:simbolo.class           # => Symbol
true.class               # => TrueClass
nil.class                # => NilClass
```

## Múltiplas Atribuições

Ruby permite atribuir múltiplas variáveis ao mesmo tempo:

```ruby
# Atribuição múltipla
a, b, c = 1, 2, 3
puts "#{a}, #{b}, #{c}"  # => 1, 2, 3

# Troca de valores
x, y = 10, 20
x, y = y, x
puts "#{x}, #{y}"  # => 20, 10

# Desempacotando arrays
numeros = [1, 2, 3, 4, 5]
primeiro, segundo, *resto = numeros
puts primeiro  # => 1
puts segundo   # => 2
puts resto.inspect  # => [3, 4, 5]

# Ignorando valores com _
_, segundo, terceiro = [1, 2, 3]
puts segundo  # => 2
```

## Operador de Atribuição Condicional

```ruby
# ||= atribui apenas se a variável for nil ou false
nome = nil
nome ||= "Padrão"
puts nome  # => "Padrão"

nome ||= "Outro"
puts nome  # => "Padrão" (não mudou!)

# Útil para valores padrão
@contador ||= 0
@contador += 1
```

## Exemplo Prático Completo

```ruby
# tipos_dados_exemplo.rb

# Coletando informações do usuário
puts "=== Cadastro de Pessoa ==="
puts

print "Nome: "
nome = gets.chomp  # String

print "Idade: "
idade = gets.chomp.to_i  # String convertida para Integer

print "Altura (em metros): "
altura = gets.chomp.to_f  # String convertida para Float

print "É estudante? (s/n): "
resposta = gets.chomp.downcase
estudante = resposta == 's'  # Boolean

# Criando um hash com os dados
pessoa = {
  nome: nome,        # Symbol como chave
  idade: idade,
  altura: altura,
  estudante: estudante,
  cadastrado_em: Time.now
}

# Exibindo informações
puts "\n=== Dados Cadastrados ==="
puts "Nome: #{pessoa[:nome]} (#{pessoa[:nome].class})"
puts "Idade: #{pessoa[:idade]} anos (#{pessoa[:idade].class})"
puts "Altura: #{pessoa[:altura]}m (#{pessoa[:altura].class})"
puts "Estudante: #{pessoa[:estudante]} (#{pessoa[:estudante].class})"
puts "Cadastrado em: #{pessoa[:cadastrado_em]}"

# Verificações
puts "\n=== Verificações ==="
puts "#{nome} é maior de idade?" if idade >= 18
puts "#{nome} é estudante" if estudante
puts "Nome tem #{nome.length} caracteres"
```

## Resumo

✅ Ruby tem **tipagem dinâmica** - não precisa declarar tipos
✅ **4 tipos de variáveis**: local, instância (@), classe (@@), global ($)
✅ **Constantes** começam com maiúscula
✅ **Tipos primitivos**: Integer, Float, String, Symbol, Boolean, Nil
✅ **Symbols** são strings imutáveis e eficientes
✅ Apenas `false` e `nil` são falsy - tudo mais é truthy
✅ Use `to_i`, `to_f`, `to_s` para converter tipos
✅ Strings com aspas duplas `"` permitem interpolação
✅ Ranges: `1..10` (inclusivo) ou `1...10` (exclusivo)

## Próximo Passo

Agora que você conhece variáveis e tipos de dados, vamos aprender sobre **[Operadores](03-operadores.md)** em Ruby!

---

[⬅️ Anterior: Introdução](01-introducao.md) | [🏠 Voltar ao Índice](README.md) | [➡️ Próximo: Operadores](03-operadores.md)
