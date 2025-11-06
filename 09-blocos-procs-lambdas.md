# 🔮 Blocos, Procs e Lambdas em Ruby

## Introdução

Blocos, Procs e Lambdas são uma das características mais poderosas do Ruby. Eles permitem passar código como argumentos para métodos, criando código extremamente expressivo e flexível.

## 1. Blocos (Blocks)

Blocos são pedaços de código entre `do...end` ou `{ }` que podem ser passados para métodos.

### Sintaxe Básica

```ruby
# Bloco com do...end (multi-linha)
[1, 2, 3].each do |numero|
  puts numero * 2
end

# Bloco com { } (uma linha)
[1, 2, 3].each { |numero| puts numero * 2 }

# Convenção:
# { } para blocos de uma linha
# do...end para blocos multi-linha
```

### Blocos com Parâmetros

```ruby
# Um parâmetro
[1, 2, 3].each { |n| puts n }

# Múltiplos parâmetros
hash = { a: 1, b: 2, c: 3 }
hash.each { |chave, valor| puts "#{chave}: #{valor}" }

# Parâmetro ignorado com _
[1, 2, 3].each { |_| puts "Item" }
```

### Criando Métodos que Aceitam Blocos

#### Usando yield

`yield` executa o bloco passado ao método:

```ruby
def executar_duas_vezes
  yield
  yield
end

executar_duas_vezes { puts "Olá!" }
# Saída:
# Olá!
# Olá!
```

#### yield com Argumentos

```ruby
def saudar
  yield("João")
  yield("Maria")
end

saudar { |nome| puts "Olá, #{nome}!" }
# Saída:
# Olá, João!
# Olá, Maria!
```

#### Verificando se Bloco foi Passado

```ruby
def metodo_com_bloco_opcional
  if block_given?
    yield
  else
    puts "Nenhum bloco foi passado"
  end
end

metodo_com_bloco_opcional
# => Nenhum bloco foi passado

metodo_com_bloco_opcional { puts "Bloco executado!" }
# => Bloco executado!
```

### Blocos com Valor de Retorno

```ruby
def calcular
  resultado = yield(5, 3)
  puts "Resultado: #{resultado}"
end

calcular { |a, b| a + b }
# => Resultado: 8

calcular { |a, b| a * b }
# => Resultado: 15
```

### Exemplo Prático - Benchmark

```ruby
def medir_tempo
  inicio = Time.now
  yield
  fim = Time.now
  puts "Tempo: #{fim - inicio} segundos"
end

medir_tempo do
  1000000.times { |i| i * 2 }
end
# => Tempo: 0.123 segundos
```

## 2. Procs

Procs (Procedures) são objetos que encapsulam blocos de código, permitindo armazená-los em variáveis e passá-los como argumentos.

### Criando Procs

```ruby
# Usando Proc.new
saudacao = Proc.new { |nome| puts "Olá, #{nome}!" }

# Usando proc (atalho)
despedida = proc { |nome| puts "Tchau, #{nome}!" }

# Executar Proc com .call
saudacao.call("João")     # => Olá, João!
despedida.call("Maria")   # => Tchau, Maria!

# Também funciona com []
saudacao["Pedro"]         # => Olá, Pedro!

# Ou com ()
saudacao.("Ana")          # => Olá, Ana!
```

### Procs como Argumentos

```ruby
def executar_proc(meu_proc)
  puts "Antes do proc"
  meu_proc.call
  puts "Depois do proc"
end

meu_codigo = Proc.new { puts "Executando proc!" }
executar_proc(meu_codigo)
# Saída:
# Antes do proc
# Executando proc!
# Depois do proc
```

### Múltiplos Procs

```ruby
def processar_numero(numero, dobrar, triplicar)
  puts "Original: #{numero}"
  puts "Dobrado: #{dobrar.call(numero)}"
  puts "Triplicado: #{triplicar.call(numero)}"
end

dobrar = Proc.new { |n| n * 2 }
triplicar = Proc.new { |n| n * 3 }

processar_numero(5, dobrar, triplicar)
# Saída:
# Original: 5
# Dobrado: 10
# Triplicado: 15
```

### Convertendo Bloco em Proc (&)

```ruby
def metodo_com_proc(&bloco)
  # & converte bloco em Proc
  puts bloco.class        # => Proc
  bloco.call("Teste")
end

metodo_com_proc { |msg| puts msg }
# => Proc
# => Teste

# Passar Proc como bloco
meu_proc = Proc.new { |n| puts n * 2 }
[1, 2, 3].each(&meu_proc)
# => 2
# => 4
# => 6
```

### Procs e Return

**⚠️ Importante:** Proc retorna do método que o definiu:

```ruby
def metodo_com_proc
  meu_proc = Proc.new { return "Retornou do proc!" }
  meu_proc.call
  "Esta linha nunca executa"
end

puts metodo_com_proc
# => Retornou do proc!
```

## 3. Lambdas

Lambdas são similares a Procs, mas com algumas diferenças importantes.

### Criando Lambdas

```ruby
# Usando lambda
saudacao = lambda { |nome| puts "Olá, #{nome}!" }

# Sintaxe ->  (mais moderna)
despedida = ->(nome) { puts "Tchau, #{nome}!" }

# Com múltiplos parâmetros
somar = ->(a, b) { a + b }

# Executar
saudacao.call("João")     # => Olá, João!
despedida.call("Maria")   # => Tchau, Maria!
puts somar.call(5, 3)     # => 8
```

### Lambda com Múltiplas Linhas

```ruby
calcular = lambda do |operacao, a, b|
  resultado = case operacao
  when :somar
    a + b
  when :subtrair
    a - b
  when :multiplicar
    a * b
  when :dividir
    a / b
  end
  puts "Resultado: #{resultado}"
  resultado
end

calcular.call(:somar, 10, 5)      # => Resultado: 15
calcular.call(:multiplicar, 4, 3) # => Resultado: 12
```

## 4. Diferenças entre Procs e Lambdas

### 1. Verificação de Argumentos

```ruby
# Lambda verifica quantidade de argumentos
lambda_exemplo = lambda { |a, b| a + b }
# lambda_exemplo.call(5)  # Erro! Falta um argumento

# Proc NÃO verifica (argumentos extras são ignorados, faltantes = nil)
proc_exemplo = Proc.new { |a, b| puts "a=#{a}, b=#{b}" }
proc_exemplo.call(5)        # => a=5, b=
proc_exemplo.call(5, 3, 7)  # => a=5, b=3 (7 é ignorado)
```

### 2. Comportamento do return

```ruby
# Lambda retorna do lambda
def teste_lambda
  meu_lambda = lambda { return "Do lambda" }
  resultado = meu_lambda.call
  "Do método (resultado: #{resultado})"
end

puts teste_lambda
# => Do método (resultado: Do lambda)

# Proc retorna do método externo
def teste_proc
  meu_proc = Proc.new { return "Do proc" }
  resultado = meu_proc.call
  "Esta linha nunca executa"
end

puts teste_proc
# => Do proc
```

### Resumo das Diferenças

| Característica | Proc | Lambda |
|----------------|------|--------|
| Verifica argumentos | ❌ Não | ✅ Sim |
| `return` | Retorna do método externo | Retorna do lambda |
| Uso recomendado | Callbacks simples | Comportamento de método |

### Verificando Tipo

```ruby
meu_proc = Proc.new { }
meu_lambda = lambda { }

puts meu_proc.lambda?   # => false
puts meu_lambda.lambda? # => true
```

## 5. Closures (Fechamentos)

Blocos, Procs e Lambdas são closures - eles "lembram" do contexto onde foram criados:

```ruby
def criar_multiplicador(fator)
  lambda { |n| n * fator }
end

multiplicar_por_2 = criar_multiplicador(2)
multiplicar_por_5 = criar_multiplicador(5)

puts multiplicar_por_2.call(10)  # => 20
puts multiplicar_por_5.call(10)  # => 50

# Cada lambda "lembra" seu próprio fator
```

### Closure com Variáveis Locais

```ruby
def contador
  count = 0
  lambda { count += 1 }
end

c1 = contador
c2 = contador

puts c1.call  # => 1
puts c1.call  # => 2
puts c1.call  # => 3

puts c2.call  # => 1 (novo contador)
puts c2.call  # => 2
```

## 6. Uso Prático - Callbacks

```ruby
class EventoManager
  def initialize
    @callbacks = []
  end

  def on_evento(&callback)
    @callbacks << callback
  end

  def disparar_evento(dados)
    @callbacks.each { |callback| callback.call(dados) }
  end
end

manager = EventoManager.new

# Registrar callbacks
manager.on_evento { |dados| puts "Callback 1: #{dados}" }
manager.on_evento { |dados| puts "Callback 2: #{dados.upcase}" }

# Disparar evento
manager.disparar_evento("Olá mundo")
# Saída:
# Callback 1: Olá mundo
# Callback 2: OLÁ MUNDO
```

## 7. Symbol to_proc (&:metodo)

Ruby permite converter símbolos em Procs:

```ruby
# Forma longa
numeros = [1, 2, 3, 4, 5]
pares = numeros.select { |n| n.even? }

# Forma curta com Symbol#to_proc
pares = numeros.select(&:even?)

# Outros exemplos
palavras = ["ruby", "python", "javascript"]

palavras.map { |p| p.upcase }
palavras.map(&:upcase)  # Equivalente

palavras.map { |p| p.length }
palavras.map(&:length)  # Equivalente

# Como funciona:
# &:upcase é equivalente a:
# { |obj| obj.upcase }
```

## 8. Método curry - Aplicação Parcial

```ruby
# Curry permite aplicar argumentos parcialmente
somar = lambda { |a, b, c| a + b + c }
somar_curried = somar.curry

# Aplicar argumentos um por vez
somar_5 = somar_curried.call(5)
somar_5_e_3 = somar_5.call(3)
resultado = somar_5_e_3.call(2)

puts resultado  # => 10 (5 + 3 + 2)

# Ou de uma vez
puts somar_curried.call(1).call(2).call(3)  # => 6
```

## 9. Exemplo Prático Completo

```ruby
# processador_dados.rb

class ProcessadorDados
  def initialize
    @filtros = []
    @transformacoes = []
  end

  # Adicionar filtro (retorna true/false)
  def adicionar_filtro(&bloco)
    @filtros << bloco
    self  # Permite encadeamento
  end

  # Adicionar transformação
  def adicionar_transformacao(&bloco)
    @transformacoes << bloco
    self
  end

  # Processar dados
  def processar(dados)
    # Aplicar filtros
    dados_filtrados = dados.select do |item|
      @filtros.all? { |filtro| filtro.call(item) }
    end

    # Aplicar transformações
    @transformacoes.reduce(dados_filtrados) do |resultado, transformacao|
      resultado.map(&transformacao)
    end
  end
end

# Usar o processador
processador = ProcessadorDados.new

# Configurar filtros
processador
  .adicionar_filtro { |n| n > 0 }        # Apenas positivos
  .adicionar_filtro { |n| n.even? }      # Apenas pares

# Configurar transformações
processador
  .adicionar_transformacao { |n| n * 2 }  # Dobrar
  .adicionar_transformacao { |n| n + 1 }  # Adicionar 1

# Processar
dados = [-5, -2, 0, 1, 2, 3, 4, 5, 6]
resultado = processador.processar(dados)

puts "Dados originais: #{dados.inspect}"
puts "Dados processados: #{resultado.inspect}"
# Dados originais: [-5, -2, 0, 1, 2, 3, 4, 5, 6]
# Dados processados: [5, 9, 13] (2*2+1, 4*2+1, 6*2+1)
```

## 10. Comparação Visual

```ruby
# Bloco - não pode ser armazenado em variável
[1, 2, 3].each { |n| puts n }

# Proc - objeto que pode ser armazenado
meu_proc = Proc.new { |n| puts n }
[1, 2, 3].each(&meu_proc)

# Lambda - como Proc mas com verificação de argumentos
meu_lambda = lambda { |n| puts n }
[1, 2, 3].each(&meu_lambda)

# Forma moderna de lambda
meu_lambda = ->(n) { puts n }
[1, 2, 3].each(&meu_lambda)
```

## Resumo

### Blocos
✅ Código entre `{ }` ou `do...end`
✅ Passados para métodos
✅ Executados com `yield`
✅ Não são objetos (não podem ser armazenados)

### Procs
✅ Objetos que encapsulam blocos
✅ Criados com `Proc.new { }`
✅ Chamados com `.call`
✅ Não verificam quantidade de argumentos
✅ `return` retorna do método externo

### Lambdas
✅ Tipo especial de Proc
✅ Criados com `lambda { }` ou `-> { }`
✅ Verificam quantidade de argumentos
✅ `return` retorna do lambda
✅ Comportam-se como métodos

### Closures
✅ Blocos, Procs e Lambdas são closures
✅ "Lembram" do contexto onde foram criados
✅ Podem acessar variáveis do escopo externo

## Quando Usar Cada Um?

- **Blocos**: Quando passar código para um método (iteradores, callbacks simples)
- **Procs**: Quando precisar armazenar código para usar depois, callbacks
- **Lambdas**: Quando precisar de comportamento de método com validação de argumentos

## Próximo Passo

Agora vamos aprender sobre **[Nomenclatura e Boas Práticas](10-nomenclatura-boas-praticas.md)** em Ruby!

---

[⬅️ Anterior: Classes e Objetos](08-classes-objetos.md) | [🏠 Voltar ao Índice](README.md) | [➡️ Próximo: Nomenclatura e Boas Práticas](10-nomenclatura-boas-praticas.md)
