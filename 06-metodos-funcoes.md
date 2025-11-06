# 🔧 Métodos e Funções em Ruby

## Introdução

Métodos (ou funções) são blocos de código reutilizáveis que executam uma tarefa específica. Em Ruby, métodos são fundamentais e tudo em Ruby é baseado em métodos, já que é uma linguagem totalmente orientada a objetos.

## 1. Definindo Métodos Básicos

### Sintaxe Básica

```ruby
# Método sem parâmetros
def saudar
  puts "Olá!"
end

# Chamar o método
saudar  # => Olá!

# Método com parâmetros
def saudar_pessoa(nome)
  puts "Olá, #{nome}!"
end

saudar_pessoa("Maria")  # => Olá, Maria!

# Múltiplos parâmetros
def somar(a, b)
  a + b
end

resultado = somar(5, 3)
puts resultado  # => 8
```

### Convenções de Nomenclatura

```ruby
# ✅ Use snake_case para nomes de métodos
def calcular_area
end

def enviar_email
end

# ✅ Use ? para métodos que retornam boolean
def par?(numero)
  numero % 2 == 0
end

# ✅ Use ! para métodos destrutivos (modificam o objeto)
def inverter!
  # modifica o objeto
end

# ❌ Evite camelCase (não idiomático em Ruby)
def calcularArea  # Ruim
end
```

## 2. Valores de Retorno

Em Ruby, métodos **sempre** retornam um valor - o valor da última expressão avaliada.

```ruby
# Retorno implícito
def dobro(numero)
  numero * 2  # Este valor é retornado automaticamente
end

puts dobro(5)  # => 10

# Retorno explícito (com return)
def maior(a, b)
  return a if a > b
  return b
end

puts maior(10, 5)  # => 10

# Múltiplos retornos (retorna array)
def dividir_com_resto(dividendo, divisor)
  quociente = dividendo / divisor
  resto = dividendo % divisor
  [quociente, resto]
end

resultado = dividir_com_resto(17, 5)
puts resultado.inspect  # => [3, 2]

# Desempacotando o retorno
q, r = dividir_com_resto(17, 5)
puts "Quociente: #{q}, Resto: #{r}"
```

### Return vs Retorno Implícito

```ruby
# ✅ Idiomático - retorno implícito
def calcular_desconto(valor, percentual)
  valor * (percentual / 100.0)
end

# ✅ Use return para sair cedo (guard clauses)
def processar_pedido(pedido)
  return nil unless pedido
  return nil unless pedido.valido?

  # processar...
  pedido
end

# ❌ Evite return desnecessário no final
def somar(a, b)
  return a + b  # Desnecessário
end

# ✅ Melhor
def somar(a, b)
  a + b
end
```

## 3. Parâmetros

### Parâmetros Opcionais (Valores Padrão)

```ruby
def saudar(nome = "visitante")
  "Olá, #{nome}!"
end

puts saudar           # => Olá, visitante!
puts saudar("João")   # => Olá, João!

# Múltiplos valores padrão
def criar_usuario(nome, idade = 18, ativo = true)
  { nome: nome, idade: idade, ativo: ativo }
end

puts criar_usuario("Maria").inspect
# => {:nome=>"Maria", :idade=>18, :ativo=>true}

puts criar_usuario("João", 25).inspect
# => {:nome=>"João", :idade=>25, :ativo=>true}
```

### Argumentos Variáveis (Splat Operator)

```ruby
# * captura múltiplos argumentos em um array
def somar(*numeros)
  numeros.sum
end

puts somar(1, 2, 3)        # => 6
puts somar(1, 2, 3, 4, 5)  # => 15

# Combinando com parâmetros normais
def criar_time(tecnico, *jogadores)
  puts "Técnico: #{tecnico}"
  puts "Jogadores: #{jogadores.join(', ')}"
end

criar_time("Carlos", "João", "Maria", "Pedro")
# => Técnico: Carlos
# => Jogadores: João, Maria, Pedro

# Splat no meio
def exemplo(primeiro, *meio, ultimo)
  puts "Primeiro: #{primeiro}"
  puts "Meio: #{meio.inspect}"
  puts "Último: #{ultimo}"
end

exemplo(1, 2, 3, 4, 5)
# => Primeiro: 1
# => Meio: [2, 3, 4]
# => Último: 5
```

### Argumentos Nomeados (Keyword Arguments)

```ruby
# Argumentos com nome (mais legível)
def criar_conta(nome:, email:, idade: 18, ativo: true)
  {
    nome: nome,
    email: email,
    idade: idade,
    ativo: ativo
  }
end

# Chamada com argumentos nomeados (ordem não importa)
usuario = criar_conta(
  email: "maria@example.com",
  nome: "Maria",
  idade: 25
)

puts usuario.inspect

# Argumentos nomeados obrigatórios
def conectar(host:, porta:)  # Sem valor padrão = obrigatório
  "Conectando em #{host}:#{porta}"
end

# conectar()  # Erro! Argumentos obrigatórios
puts conectar(host: "localhost", porta: 3000)
```

### Double Splat (**) - Keyword Arguments Variáveis

```ruby
# ** captura argumentos nomeados extras em um hash
def configurar(**opcoes)
  opcoes.each do |chave, valor|
    puts "#{chave}: #{valor}"
  end
end

configurar(cor: "azul", tamanho: "M", desconto: true)
# => cor: azul
# => tamanho: M
# => desconto: true

# Combinando tudo
def criar_produto(nome, preco, descricao: "", **extras)
  {
    nome: nome,
    preco: preco,
    descricao: descricao,
    extras: extras
  }
end

produto = criar_produto(
  "Notebook",
  3000,
  descricao: "Notebook gamer",
  marca: "Dell",
  cor: "preto",
  garantia: "2 anos"
)

puts produto.inspect
```

## 4. Métodos com Blocos

Métodos podem receber blocos de código como parâmetro.

### yield - Executar Bloco

```ruby
def executar_com_log
  puts "Iniciando..."
  yield  # Executa o bloco passado
  puts "Finalizado!"
end

executar_com_log do
  puts "Executando tarefa..."
end

# Saída:
# Iniciando...
# Executando tarefa...
# Finalizado!
```

### yield com Argumentos

```ruby
def repetir(vezes)
  vezes.times do |i|
    yield(i)  # Passa o índice para o bloco
  end
end

repetir(3) do |numero|
  puts "Iteração #{numero}"
end

# Saída:
# Iteração 0
# Iteração 1
# Iteração 2
```

### Verificando se Bloco foi Passado

```ruby
def executar_se_houver_bloco
  if block_given?
    yield
  else
    puts "Nenhum bloco foi passado"
  end
end

executar_se_houver_bloco
# => Nenhum bloco foi passado

executar_se_houver_bloco do
  puts "Bloco executado!"
end
# => Bloco executado!
```

### Capturando Bloco em Variável

```ruby
def executar(&bloco)
  puts "Antes do bloco"
  bloco.call  # Executa o bloco
  puts "Depois do bloco"
end

executar { puts "Dentro do bloco" }

# Passando bloco adiante
def wrapper(&bloco)
  outro_metodo(&bloco)
end

def outro_metodo
  yield
end

wrapper { puts "Funcionou!" }
```

## 5. Métodos Interrogativos (?)

Métodos que retornam boolean devem terminar com `?`:

```ruby
def par?(numero)
  numero.even?
end

def vazio?(texto)
  texto.nil? || texto.empty?
end

def maior_de_idade?(idade)
  idade >= 18
end

# Uso
puts par?(4)              # => true
puts vazio?("")           # => true
puts maior_de_idade?(25)  # => true

# Em classes
class Usuario
  def initialize(idade)
    @idade = idade
  end

  def adulto?
    @idade >= 18
  end

  def idoso?
    @idade >= 65
  end
end

usuario = Usuario.new(30)
puts usuario.adulto?  # => true
```

## 6. Métodos Destrutivos (!)

Métodos que terminam com `!` modificam o objeto original:

```ruby
# Método normal - retorna novo objeto
def inverter(texto)
  texto.reverse
end

# Método destrutivo - modifica o objeto original
def inverter!(texto)
  texto.replace(texto.reverse)
end

texto = "Ruby"
puts inverter(texto)   # => ybuR
puts texto             # => Ruby (original não mudou)

inverter!(texto)
puts texto             # => ybuR (original foi modificado!)

# Exemplo com arrays
numeros = [3, 1, 4, 1, 5, 9]
puts numeros.sort.inspect      # => [1, 1, 3, 4, 5, 9]
puts numeros.inspect           # => [3, 1, 4, 1, 5, 9]

numeros.sort!
puts numeros.inspect           # => [1, 1, 3, 4, 5, 9]
```

## 7. Escopo de Variáveis

```ruby
# Variáveis fora do método não são acessíveis
x = 10

def mostrar_x
  # puts x  # Erro! x não existe aqui
  x = 20    # Esta é uma variável local diferente
  puts x
end

mostrar_x  # => 20
puts x     # => 10

# Parâmetros criam variáveis locais
def processar(valor)
  # 'valor' só existe dentro deste método
  valor * 2
end

# Blocos têm acesso a variáveis externas
multiplicador = 3
[1, 2, 3].map { |n| n * multiplicador }  # => [3, 6, 9]
```

## 8. Métodos Privados e Protegidos

```ruby
class Pessoa
  def initialize(nome, idade)
    @nome = nome
    @idade = idade
  end

  # Métodos públicos (padrão)
  def apresentar
    "#{saudacao}, meu nome é #{@nome}"
  end

  # Tudo abaixo é privado
  private

  def saudacao
    "Olá"
  end

  # Também pode declarar individual
  private def metodo_privado
    "Só acessível internamente"
  end
end

pessoa = Pessoa.new("João", 30)
puts pessoa.apresentar
# puts pessoa.saudacao  # Erro! Método privado

# Protected - acessível por instâncias da mesma classe
class Conta
  def initialize(saldo)
    @saldo = saldo
  end

  def transferir_para(outra_conta, valor)
    if @saldo >= valor
      @saldo -= valor
      outra_conta.receber(valor)
    end
  end

  protected

  def receber(valor)
    @saldo += valor
  end
end
```

## 9. Alias - Criando Apelidos para Métodos

```ruby
class Calculadora
  def somar(a, b)
    a + b
  end

  alias adicionar somar
end

calc = Calculadora.new
puts calc.somar(5, 3)      # => 8
puts calc.adicionar(5, 3)  # => 8
```

## 10. Exemplo Prático Completo

```ruby
# calculadora.rb

class Calculadora
  def initialize
    @historico = []
  end

  # Operações básicas
  def somar(*numeros)
    resultado = numeros.sum
    registrar("soma", numeros, resultado)
    resultado
  end

  def subtrair(a, b)
    resultado = a - b
    registrar("subtração", [a, b], resultado)
    resultado
  end

  def multiplicar(*numeros)
    resultado = numeros.reduce(1, :*)
    registrar("multiplicação", numeros, resultado)
    resultado
  end

  def dividir(a, b)
    return erro("Divisão por zero!") if b.zero?

    resultado = a.to_f / b
    registrar("divisão", [a, b], resultado)
    resultado
  end

  # Operações avançadas
  def potencia(base, expoente = 2)
    resultado = base ** expoente
    registrar("potência", [base, expoente], resultado)
    resultado
  end

  def raiz_quadrada(numero)
    return erro("Número negativo!") if numero < 0

    resultado = Math.sqrt(numero)
    registrar("raiz quadrada", [numero], resultado)
    resultado
  end

  # Operações com blocos
  def calcular_com_numeros(*numeros, &operacao)
    return erro("Nenhum bloco fornecido") unless block_given?

    resultado = numeros.reduce(&operacao)
    registrar("operação customizada", numeros, resultado)
    resultado
  end

  # Consultar histórico
  def mostrar_historico
    return puts "Nenhuma operação realizada." if historico_vazio?

    puts "\n=== Histórico de Operações ==="
    @historico.each_with_index do |op, i|
      puts "#{i + 1}. #{op}"
    end
  end

  def limpar_historico
    @historico.clear
    puts "Histórico limpo!"
  end

  private

  def registrar(operacao, valores, resultado)
    entrada = valores.join(", ")
    @historico << "#{operacao}(#{entrada}) = #{resultado}"
  end

  def erro(mensagem)
    puts "Erro: #{mensagem}"
    nil
  end

  def historico_vazio?
    @historico.empty?
  end
end

# Usando a calculadora
calc = Calculadora.new

puts calc.somar(5, 3, 2)           # => 10
puts calc.multiplicar(4, 5, 2)     # => 40
puts calc.dividir(10, 2)           # => 5.0
puts calc.potencia(2, 3)           # => 8
puts calc.raiz_quadrada(16)        # => 4.0

# Operação customizada
resultado = calc.calcular_com_numeros(10, 5, 2) { |a, b| a - b }
puts resultado  # => 3

calc.mostrar_historico
```

## Resumo

✅ Use `def` para definir métodos
✅ Métodos retornam a última expressão (retorno implícito)
✅ Use `return` apenas para sair cedo (guard clauses)
✅ Parâmetros opcionais com valores padrão: `def metodo(param = valor)`
✅ Argumentos variáveis com `*args` (array) e `**kwargs` (hash)
✅ Argumentos nomeados são mais legíveis
✅ Use `?` no final para métodos que retornam boolean
✅ Use `!` no final para métodos destrutivos
✅ Use `yield` ou `&bloco` para trabalhar com blocos
✅ Métodos são privados com `private`, protegidos com `protected`
✅ Use snake_case para nomes de métodos

## Boas Práticas

1. Métodos devem fazer **uma coisa** e fazer bem
2. Nomes devem ser descritivos (preferir `calcular_total_com_desconto` a `calc`)
3. Evite métodos muito longos (máximo 10-15 linhas)
4. Use guard clauses no início para validações
5. Prefira argumentos nomeados quando houver muitos parâmetros
6. Evite modificar parâmetros recebidos (use ! explicitamente)
7. Documente métodos complexos

## Próximo Passo

Agora vamos aprender sobre **[Arrays e Hashes](07-arrays-hashes.md)** em Ruby!

---

[⬅️ Anterior: Laços de Repetição](05-lacos-repeticao.md) | [🏠 Voltar ao Índice](README.md) | [➡️ Próximo: Arrays e Hashes](07-arrays-hashes.md)
