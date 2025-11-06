# 🏗️ Classes e Objetos - Programação Orientada a Objetos

## Introdução

Ruby é uma linguagem **totalmente orientada a objetos**. Tudo em Ruby é um objeto, incluindo números, strings e até mesmo classes!

```ruby
# Tudo é objeto em Ruby
42.class         # => Integer
"texto".class    # => String
true.class       # => TrueClass
[].class         # => Array
{}.class         # => Hash
Class.class      # => Class (até Class é um objeto!)
```

## 1. Definindo Classes

### Classe Básica

```ruby
# Definir uma classe
class Pessoa
end

# Criar um objeto (instanciar)
pessoa = Pessoa.new
puts pessoa.class  # => Pessoa
```

### Classe com Inicialização

```ruby
class Pessoa
  # Construtor - chamado ao criar novo objeto
  def initialize(nome, idade)
    @nome = nome      # Variável de instância
    @idade = idade
  end

  # Método de instância
  def apresentar
    "Olá, meu nome é #{@nome} e tenho #{@idade} anos."
  end
end

# Criar objeto passando argumentos
pessoa = Pessoa.new("João", 30)
puts pessoa.apresentar
# => Olá, meu nome é João e tenho 30 anos.
```

## 2. Variáveis de Instância

Variáveis que pertencem a cada objeto individual (começam com `@`).

```ruby
class Contador
  def initialize
    @count = 0  # Cada objeto tem seu próprio @count
  end

  def incrementar
    @count += 1
  end

  def valor
    @count
  end
end

c1 = Contador.new
c2 = Contador.new

c1.incrementar
c1.incrementar
puts c1.valor  # => 2

puts c2.valor  # => 0 (cada objeto é independente)
```

## 3. Getters e Setters

### Forma Manual

```ruby
class Pessoa
  def initialize(nome, idade)
    @nome = nome
    @idade = idade
  end

  # Getter (ler valor)
  def nome
    @nome
  end

  # Setter (modificar valor)
  def nome=(novo_nome)
    @nome = novo_nome
  end

  def idade
    @idade
  end

  def idade=(nova_idade)
    if nova_idade >= 0
      @idade = nova_idade
    else
      puts "Idade inválida!"
    end
  end
end

pessoa = Pessoa.new("Maria", 25)
puts pessoa.nome        # => Maria

pessoa.nome = "Maria Silva"
puts pessoa.nome        # => Maria Silva

pessoa.idade = 26
puts pessoa.idade       # => 26
```

### Usando attr_accessor, attr_reader, attr_writer

Ruby fornece atalhos para criar getters e setters:

```ruby
class Pessoa
  # Cria getter e setter
  attr_accessor :nome, :email

  # Apenas getter (somente leitura)
  attr_reader :id

  # Apenas setter (somente escrita)
  attr_writer :senha

  def initialize(id, nome)
    @id = id
    @nome = nome
  end
end

pessoa = Pessoa.new(1, "João")

# attr_accessor permite ler e escrever
puts pessoa.nome        # => João
pessoa.nome = "João Silva"

# attr_reader apenas permite ler
puts pessoa.id          # => 1
# pessoa.id = 2         # Erro! Não tem setter

# attr_writer apenas permite escrever
pessoa.senha = "123456"
# puts pessoa.senha     # Erro! Não tem getter
```

**Resumo:**
- `attr_reader :nome` → cria apenas `def nome`
- `attr_writer :nome` → cria apenas `def nome=(valor)`
- `attr_accessor :nome` → cria ambos (getter e setter)

## 4. Métodos de Instância vs Métodos de Classe

### Métodos de Instância

Operam em objetos individuais:

```ruby
class Cachorro
  def initialize(nome)
    @nome = nome
  end

  # Método de instância
  def latir
    "#{@nome}: Au au!"
  end
end

dog = Cachorro.new("Rex")
puts dog.latir  # => Rex: Au au!
```

### Métodos de Classe

Operam na classe, não em instâncias individuais:

```ruby
class Matematica
  # Método de classe (usa self.)
  def self.somar(a, b)
    a + b
  end

  # Alternativa: class << self
  class << self
    def subtrair(a, b)
      a - b
    end
  end
end

# Chamar método de classe (sem instanciar)
puts Matematica.somar(5, 3)      # => 8
puts Matematica.subtrair(10, 4)  # => 6
```

### Exemplo Prático - Contador de Instâncias

```ruby
class Usuario
  # Variável de classe (compartilhada entre todas as instâncias)
  @@total = 0

  def initialize(nome)
    @nome = nome
    @@total += 1
  end

  # Método de classe para acessar variável de classe
  def self.total
    @@total
  end
end

u1 = Usuario.new("João")
u2 = Usuario.new("Maria")
u3 = Usuario.new("Pedro")

puts Usuario.total  # => 3
```

## 5. Constantes

Valores que não devem mudar (por convenção, MAIÚSCULAS):

```ruby
class Circulo
  PI = 3.14159  # Constante

  def initialize(raio)
    @raio = raio
  end

  def area
    PI * @raio ** 2
  end
end

c = Circulo.new(5)
puts c.area          # => 78.53975

puts Circulo::PI     # Acessar constante fora da classe
```

## 6. Herança

Classes podem herdar características de outras classes:

```ruby
# Classe pai (superclasse)
class Animal
  def initialize(nome)
    @nome = nome
  end

  def apresentar
    "Eu sou #{@nome}"
  end

  def fazer_som
    "Som genérico"
  end
end

# Classes filhas (subclasses)
class Cachorro < Animal
  def fazer_som
    "Au au!"
  end

  def abanar_rabo
    "#{@nome} está abanando o rabo"
  end
end

class Gato < Animal
  def fazer_som
    "Miau!"
  end

  def ronronar
    "#{@nome} está ronronando"
  end
end

# Usando
dog = Cachorro.new("Rex")
puts dog.apresentar      # => Eu sou Rex (herdado)
puts dog.fazer_som       # => Au au! (sobrescrito)
puts dog.abanar_rabo     # => Rex está abanando o rabo

gato = Gato.new("Mimi")
puts gato.apresentar     # => Eu sou Mimi (herdado)
puts gato.fazer_som      # => Miau! (sobrescrito)
puts gato.ronronar       # => Mimi está ronronando
```

### super - Chamando Método da Classe Pai

```ruby
class Veiculo
  def initialize(marca, modelo)
    @marca = marca
    @modelo = modelo
  end

  def informacoes
    "#{@marca} #{@modelo}"
  end
end

class Carro < Veiculo
  def initialize(marca, modelo, portas)
    super(marca, modelo)  # Chama initialize da classe pai
    @portas = portas
  end

  def informacoes
    "#{super} - #{@portas} portas"  # Chama informacoes da classe pai
  end
end

carro = Carro.new("Toyota", "Corolla", 4)
puts carro.informacoes
# => Toyota Corolla - 4 portas
```

## 7. Encapsulamento - public, private, protected

### Public (Padrão)

Métodos públicos podem ser chamados por qualquer um:

```ruby
class Exemplo
  def metodo_publico
    "Acessível de qualquer lugar"
  end
end

obj = Exemplo.new
puts obj.metodo_publico
```

### Private

Métodos privados só podem ser chamados dentro da classe:

```ruby
class ContaBancaria
  def initialize(saldo)
    @saldo = saldo
  end

  def sacar(valor)
    if valor_valido?(valor)
      @saldo -= valor
      "Saque realizado. Novo saldo: #{@saldo}"
    else
      "Valor inválido"
    end
  end

  private  # Tudo abaixo é privado

  def valor_valido?(valor)
    valor > 0 && valor <= @saldo
  end
end

conta = ContaBancaria.new(1000)
puts conta.sacar(100)       # => Funciona
# conta.valor_valido?(50)   # Erro! Método privado
```

### Protected

Métodos protegidos podem ser chamados por instâncias da mesma classe:

```ruby
class Pessoa
  def initialize(idade)
    @idade = idade
  end

  def mais_velho_que?(outra_pessoa)
    @idade > outra_pessoa.idade  # Pode acessar método protected de outra instância
  end

  protected

  def idade
    @idade
  end
end

p1 = Pessoa.new(30)
p2 = Pessoa.new(25)

puts p1.mais_velho_que?(p2)  # => true
# puts p1.idade  # Erro! Protected não é acessível externamente
```

## 8. Métodos Especiais

### to_s - Representação em String

```ruby
class Pessoa
  def initialize(nome, idade)
    @nome = nome
    @idade = idade
  end

  def to_s
    "#{@nome}, #{@idade} anos"
  end
end

pessoa = Pessoa.new("Maria", 28)
puts pessoa  # Chama automaticamente to_s
# => Maria, 28 anos
```

### Operadores Customizados

```ruby
class Dinheiro
  attr_reader :valor

  def initialize(valor)
    @valor = valor
  end

  def +(outro)
    Dinheiro.new(@valor + outro.valor)
  end

  def -(outro)
    Dinheiro.new(@valor - outro.valor)
  end

  def *(quantidade)
    Dinheiro.new(@valor * quantidade)
  end

  def to_s
    "R$ #{@valor}"
  end
end

d1 = Dinheiro.new(100)
d2 = Dinheiro.new(50)

puts d1 + d2  # => R$ 150
puts d1 - d2  # => R$ 50
puts d1 * 3   # => R$ 300
```

### Comparações

```ruby
class Produto
  include Comparable  # Permite usar <, >, ==, etc.

  attr_reader :nome, :preco

  def initialize(nome, preco)
    @nome = nome
    @preco = preco
  end

  def <=>(outro)
    @preco <=> outro.preco  # Comparar por preço
  end

  def to_s
    "#{@nome}: R$ #{@preco}"
  end
end

p1 = Produto.new("Mouse", 50)
p2 = Produto.new("Teclado", 150)
p3 = Produto.new("Monitor", 800)

puts p1 < p2   # => true
puts p3 > p2   # => true
puts p1 == p2  # => false

produtos = [p3, p1, p2]
puts produtos.sort
# Mouse: R$ 50
# Teclado: R$ 150
# Monitor: R$ 800
```

## 9. Class Variables vs Instance Variables

```ruby
class Contador
  # Variável de classe (compartilhada)
  @@total = 0

  def initialize(nome)
    # Variável de instância (única para cada objeto)
    @nome = nome
    @count = 0
    @@total += 1
  end

  def incrementar
    @count += 1
  end

  def self.total_objetos
    @@total
  end

  def exibir
    puts "#{@nome}: #{@count} (Total de objetos: #{@@total})"
  end
end

c1 = Contador.new("C1")
c2 = Contador.new("C2")

c1.incrementar
c1.incrementar
c1.exibir  # => C1: 2 (Total de objetos: 2)

c2.incrementar
c2.exibir  # => C2: 1 (Total de objetos: 2)

puts Contador.total_objetos  # => 2
```

## 10. Exemplo Prático Completo

```ruby
# sistema_biblioteca.rb

class Livro
  attr_reader :titulo, :autor, :isbn
  attr_accessor :disponivel

  @@total_livros = 0

  def initialize(titulo, autor, isbn)
    @titulo = titulo
    @autor = autor
    @isbn = isbn
    @disponivel = true
    @@total_livros += 1
  end

  def self.total
    @@total_livros
  end

  def emprestar
    if @disponivel
      @disponivel = false
      "Livro '#{@titulo}' emprestado com sucesso!"
    else
      "Livro '#{@titulo}' não está disponível."
    end
  end

  def devolver
    @disponivel = true
    "Livro '#{@titulo}' devolvido com sucesso!"
  end

  def to_s
    status = @disponivel ? "Disponível" : "Emprestado"
    "#{@titulo} - #{@autor} [#{status}]"
  end
end

class Usuario
  attr_reader :nome, :livros_emprestados

  def initialize(nome)
    @nome = nome
    @livros_emprestados = []
  end

  def emprestar_livro(livro)
    if livro.disponivel
      livro.emprestar
      @livros_emprestados << livro
      true
    else
      puts "Livro não disponível."
      false
    end
  end

  def devolver_livro(livro)
    if @livros_emprestados.include?(livro)
      livro.devolver
      @livros_emprestados.delete(livro)
      true
    else
      puts "Você não tem este livro."
      false
    end
  end

  def listar_emprestimos
    if @livros_emprestados.empty?
      puts "#{@nome} não tem livros emprestados."
    else
      puts "\n#{@nome} - Livros emprestados:"
      @livros_emprestados.each do |livro|
        puts "  - #{livro.titulo}"
      end
    end
  end
end

class Biblioteca
  def initialize(nome)
    @nome = nome
    @livros = []
    @usuarios = []
  end

  def adicionar_livro(livro)
    @livros << livro
    puts "Livro '#{livro.titulo}' adicionado à biblioteca."
  end

  def cadastrar_usuario(usuario)
    @usuarios << usuario
    puts "Usuário '#{usuario.nome}' cadastrado."
  end

  def listar_livros_disponiveis
    disponiveis = @livros.select { |l| l.disponivel }

    if disponiveis.empty?
      puts "\nNenhum livro disponível."
    else
      puts "\n=== Livros Disponíveis na #{@nome} ==="
      disponiveis.each_with_index do |livro, i|
        puts "#{i + 1}. #{livro}"
      end
    end
  end

  def relatorio
    total = @livros.size
    disponiveis = @livros.count { |l| l.disponivel }
    emprestados = total - disponiveis

    puts "\n=== Relatório da #{@nome} ==="
    puts "Total de livros: #{total}"
    puts "Disponíveis: #{disponiveis}"
    puts "Emprestados: #{emprestados}"
    puts "Usuários cadastrados: #{@usuarios.size}"
  end
end

# Usando o sistema
biblioteca = Biblioteca.new("Biblioteca Municipal")

# Adicionar livros
livro1 = Livro.new("1984", "George Orwell", "123")
livro2 = Livro.new("O Hobbit", "J.R.R. Tolkien", "456")
livro3 = Livro.new("Clean Code", "Robert Martin", "789")

biblioteca.adicionar_livro(livro1)
biblioteca.adicionar_livro(livro2)
biblioteca.adicionar_livro(livro3)

# Cadastrar usuários
user1 = Usuario.new("João")
user2 = Usuario.new("Maria")

biblioteca.cadastrar_usuario(user1)
biblioteca.cadastrar_usuario(user2)

# Empréstimos
biblioteca.listar_livros_disponiveis

user1.emprestar_livro(livro1)
user1.emprestar_livro(livro2)
user2.emprestar_livro(livro3)

biblioteca.listar_livros_disponiveis

user1.listar_emprestimos
user2.listar_emprestimos

# Devoluções
user1.devolver_livro(livro1)

biblioteca.relatorio

puts "\nTotal de livros criados: #{Livro.total}"
```

## Resumo

✅ **Classes** definem estrutura com `class NomeDaClasse`
✅ **Objetos** são criados com `.new`
✅ **initialize** é o construtor
✅ **@variavel** são variáveis de instância
✅ **@@variavel** são variáveis de classe
✅ **attr_accessor/reader/writer** criam getters/setters
✅ **self.metodo** define métodos de classe
✅ **Herança** com `class Filha < Pai`
✅ **super** chama método da classe pai
✅ **private/protected** controlam acesso
✅ **to_s** customiza representação em string

## Conceitos POO em Ruby

- **Encapsulamento**: Controle de acesso com public/private/protected
- **Herança**: Reutilização de código com `<`
- **Polimorfismo**: Sobrescrita de métodos
- **Abstração**: Ocultar complexidade com interfaces simples

## Próximo Passo

Agora vamos aprender sobre **[Blocos, Procs e Lambdas](09-blocos-procs-lambdas.md)** - conceitos avançados de Ruby!

---

[⬅️ Anterior: Arrays e Hashes](07-arrays-hashes.md) | [🏠 Voltar ao Índice](README.md) | [➡️ Próximo: Blocos, Procs e Lambdas](09-blocos-procs-lambdas.md)
