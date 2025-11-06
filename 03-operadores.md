# ➕➖✖️➗ Operadores em Ruby

## Introdução

Operadores são símbolos especiais que realizam operações em variáveis e valores. Ruby possui diversos tipos de operadores que tornam o código mais expressivo e conciso.

## 1. Operadores Aritméticos

Usados para realizar operações matemáticas:

```ruby
a = 10
b = 3

# Adição
puts a + b    # => 13

# Subtração
puts a - b    # => 7

# Multiplicação
puts a * b    # => 30

# Divisão
puts a / b    # => 3 (divisão inteira)
puts a.to_f / b  # => 3.333... (divisão com float)

# Módulo (resto da divisão)
puts a % b    # => 1

# Exponenciação
puts a ** b   # => 1000 (10^3)

# Divisão inteira (retorna o quociente)
puts a / b    # => 3
```

### Exemplos Práticos

```ruby
# Verificar se número é par
numero = 10
numero % 2 == 0  # => true (é par)

# Calcular área de círculo
raio = 5
PI = 3.14159
area = PI * raio ** 2  # => 78.53975

# Converter Celsius para Fahrenheit
celsius = 25
fahrenheit = celsius * 9.0 / 5 + 32  # => 77.0
```

## 2. Operadores de Atribuição

Atribuem valores a variáveis:

```ruby
# Atribuição simples
x = 10

# Atribuição composta
x += 5   # x = x + 5  => 15
x -= 3   # x = x - 3  => 12
x *= 2   # x = x * 2  => 24
x /= 4   # x = x / 4  => 6
x %= 4   # x = x % 4  => 2
x **= 3  # x = x ** 3 => 8

# Atribuição condicional
nome = nil
nome ||= "Padrão"  # Atribui apenas se nome for nil ou false
puts nome  # => "Padrão"

nome ||= "Novo"
puts nome  # => "Padrão" (não mudou pois já tinha valor)
```

## 3. Operadores de Comparação

Comparam dois valores e retornam `true` ou `false`:

```ruby
a = 10
b = 20

# Igual a
a == b    # => false

# Diferente de
a != b    # => true

# Maior que
a > b     # => false

# Menor que
a < b     # => true

# Maior ou igual
a >= 10   # => true

# Menor ou igual
b <= 20   # => true

# Comparação combinada (spaceship operator)
a <=> b   # => -1 (a < b)
b <=> a   # => 1  (b > a)
a <=> a   # => 0  (a == a)
```

### Operador Spaceship (<=>)

Muito útil para ordenação:

```ruby
# Retorna:
# -1 se o primeiro valor é menor
#  0 se os valores são iguais
#  1 se o primeiro valor é maior

1 <=> 2   # => -1
2 <=> 2   # => 0
2 <=> 1   # => 1

# Usado em sort
numeros = [3, 1, 4, 1, 5, 9, 2, 6]
numeros.sort { |a, b| a <=> b }  # => [1, 1, 2, 3, 4, 5, 6, 9]

# Ordem decrescente
numeros.sort { |a, b| b <=> a }  # => [9, 6, 5, 4, 3, 2, 1, 1]
```

### Comparação de Igualdade (== vs ===  vs eql? vs equal?)

```ruby
# == compara valores
1 == 1.0    # => true (valores são iguais)

# eql? compara valor E tipo
1.eql?(1.0) # => false (tipos diferentes)

# equal? compara identidade do objeto (mesmo objeto na memória)
a = "texto"
b = "texto"
c = a

a == b      # => true (mesmo valor)
a.equal?(b) # => false (objetos diferentes)
a.equal?(c) # => true (mesmo objeto)

# === usado em case/when e ranges
(1..10) === 5     # => true
String === "texto" # => true
/ruby/ === "I love ruby"  # => true
```

## 4. Operadores Lógicos

Combinam expressões booleanas:

```ruby
# AND lógico (&&)
true && true    # => true
true && false   # => false
false && true   # => false

# OR lógico (||)
true || false   # => true
false || false  # => false
false || true   # => true

# NOT lógico (!)
!true           # => false
!false          # => true

# Exemplos práticos
idade = 25
tem_carteira = true

# Pode dirigir se tem 18+ anos E tem carteira
pode_dirigir = idade >= 18 && tem_carteira  # => true

# É menor de idade ou idoso
idade_especial = idade < 18 || idade >= 65  # => false
```

### Avaliação de Curto-Circuito

Ruby usa "short-circuit evaluation" - para de avaliar assim que o resultado é determinado:

```ruby
# Com &&, se o primeiro for false, não avalia o segundo
false && puts("Não vai imprimir")  # Não imprime nada

# Com ||, se o primeiro for true, não avalia o segundo
true || puts("Não vai imprimir")   # Não imprime nada

# Útil para evitar erros
valor = nil
resultado = valor && valor.length  # => nil (não dá erro)
# resultado = valor.length  # Daria erro!
```

### Versões Verbais (and, or, not)

Ruby também tem versões em palavras, mas com **precedência diferente**:

```ruby
# Preferir && e || na maioria dos casos

# and, or, not têm precedência muito baixa
a = true and false  # a = true (atribuição acontece primeiro!)
a = true && false   # a = false

# Use and/or principalmente para controle de fluxo
arquivo = File.open("teste.txt") or raise "Erro ao abrir arquivo"
```

## 5. Operadores de Range

Criam sequências:

```ruby
# Range inclusivo (..)
1..5      # => 1, 2, 3, 4, 5
'a'..'e'  # => a, b, c, d, e

# Range exclusivo (...)
1...5     # => 1, 2, 3, 4
'a'...'e' # => a, b, c, d

# Verificar se valor está no range
(1..10).include?(5)   # => true
(1..10).cover?(5)     # => true (mais rápido)

# Converter para array
(1..5).to_a          # => [1, 2, 3, 4, 5]

# Em condicionais
idade = 25
case idade
when 0..12
  puts "Criança"
when 13..17
  puts "Adolescente"
when 18..59
  puts "Adulto"
else
  puts "Idoso"
end
```

## 6. Operadores Bit a Bit

Operam em nível de bits (menos comuns):

```ruby
a = 60  # 0011 1100 em binário
b = 13  # 0000 1101 em binário

# AND bit a bit
a & b   # => 12 (0000 1100)

# OR bit a bit
a | b   # => 61 (0011 1101)

# XOR bit a bit
a ^ b   # => 49 (0011 0001)

# NOT bit a bit
~a      # => -61

# Deslocamento à esquerda
a << 2  # => 240 (1111 0000)

# Deslocamento à direita
a >> 2  # => 15 (0000 1111)
```

## 7. Operadores Especiais do Ruby

### Operador de Navegação Segura (&.)

Evita erros ao chamar métodos em objetos que podem ser `nil`:

```ruby
usuario = nil

# Sem navegação segura - gera erro
# usuario.nome  # NoMethodError!

# Com navegação segura - retorna nil
usuario&.nome  # => nil

# Exemplo prático
usuarios = [
  { nome: "Maria", idade: 25 },
  nil,
  { nome: "João", idade: 30 }
]

usuarios.each do |u|
  puts u&.[](:nome) || "Desconhecido"
end
# => Maria
# => Desconhecido
# => João
```

### Operador Ternário (? :)

Forma concisa de if/else:

```ruby
# Sintaxe: condição ? valor_se_true : valor_se_false

idade = 20
status = idade >= 18 ? "Maior de idade" : "Menor de idade"
puts status  # => "Maior de idade"

# Equivalente a:
if idade >= 18
  status = "Maior de idade"
else
  status = "Menor de idade"
end

# Pode ser aninhado (mas evite, fica confuso)
nota = 85
conceito = nota >= 90 ? "A" : nota >= 80 ? "B" : nota >= 70 ? "C" : "D"
```

### Operador de Definição Condicional (||=)

Atribui valor apenas se a variável for `nil` ou `false`:

```ruby
nome = nil
nome ||= "João"
puts nome  # => "João"

nome ||= "Maria"
puts nome  # => "João" (não mudou)

# Útil para inicialização preguiçosa
@cache ||= carregar_dados_pesados()

# Em hashes
contador = {}
contador[:visitas] ||= 0
contador[:visitas] += 1
```

### Operador Splat (*)

Expande arrays e captura argumentos variáveis:

```ruby
# Expandir array
numeros = [1, 2, 3]
puts *numeros  # Imprime cada número em uma linha

# Combinar arrays
a = [1, 2, 3]
b = [4, 5, 6]
c = [*a, *b]  # => [1, 2, 3, 4, 5, 6]

# Em atribuições
primeiro, *resto = [1, 2, 3, 4, 5]
puts primeiro  # => 1
puts resto.inspect  # => [2, 3, 4, 5]

# Em definição de métodos (argumentos variáveis)
def soma(*numeros)
  numeros.sum
end

soma(1, 2, 3, 4, 5)  # => 15
```

### Operador Double Splat (**)

Similar ao splat, mas para hashes:

```ruby
# Expandir hash
opcoes = { cor: "azul", tamanho: "M" }
mais_opcoes = { **opcoes, preco: 50 }
# => { cor: "azul", tamanho: "M", preco: 50 }

# Em métodos
def configurar(**opcoes)
  puts opcoes.inspect
end

configurar(cor: "vermelho", tamanho: "G")
# => {:cor=>"vermelho", :tamanho=>"G"}
```

## 8. Precedência de Operadores

Operadores são avaliados em uma ordem específica (do maior para o menor):

```ruby
# 1. ! ~ +@ (unários)
# 2. **
# 3. -@ (menos unário)
# 4. * / %
# 5. + -
# 6. << >>
# 7. &
# 8. | ^
# 9. > >= < <=
# 10. <=> == === != =~ !~
# 11. &&
# 12. ||
# 13. .. ...
# 14. ? : (ternário)
# 15. = += -= *= /= etc.
# 16. not
# 17. or and

# Exemplos
resultado = 2 + 3 * 4    # => 14 (não 20)
resultado = (2 + 3) * 4  # => 20 (parênteses alteram precedência)

resultado = 10 > 5 && 3 < 7  # => true
resultado = 10 > 5 and 3 < 7 # => true (mesmo resultado, mas cuidado!)
```

**Dica:** Quando em dúvida, use parênteses para deixar a intenção clara!

## Exemplo Prático Completo

```ruby
# calculadora_imc.rb

puts "=== Calculadora de IMC ==="
puts

print "Digite seu peso (kg): "
peso = gets.chomp.to_f

print "Digite sua altura (m): "
altura = gets.chomp.to_f

# Calcular IMC usando operadores aritméticos
imc = peso / (altura ** 2)

# Formatar resultado
imc_formatado = imc.round(2)

puts "\nSeu IMC é: #{imc_formatado}"

# Usar operadores de comparação e lógicos para classificação
classificacao = case imc
when 0...18.5
  "Abaixo do peso"
when 18.5...25
  "Peso normal"
when 25...30
  "Sobrepeso"
when 30...35
  "Obesidade grau I"
when 35...40
  "Obesidade grau II"
else
  "Obesidade grau III"
end

puts "Classificação: #{classificacao}"

# Operador ternário para recomendação
recomendacao = imc >= 18.5 && imc < 25 ?
  "Seu peso está normal! Continue assim!" :
  "Considere consultar um profissional de saúde."

puts "\n#{recomendacao}"
```

## Métodos que Parecem Operadores

Em Ruby, muitos "operadores" são na verdade métodos:

```ruby
# Esses são métodos, não operadores!
1 + 2      # Equivalente a: 1.+(2)
10 / 2     # Equivalente a: 10./(2)
"a" * 3    # Equivalente a: "a".*(3)

# Você pode redefinir esses métodos!
class Numero
  attr_reader :valor

  def initialize(valor)
    @valor = valor
  end

  def +(outro)
    Numero.new(@valor + outro.valor)
  end

  def to_s
    @valor.to_s
  end
end

n1 = Numero.new(5)
n2 = Numero.new(3)
puts n1 + n2  # => 8
```

## Resumo

✅ **Aritméticos**: +, -, *, /, %, **
✅ **Comparação**: ==, !=, <, >, <=, >=, <=>
✅ **Lógicos**: &&, ||, ! (preferir sobre and, or, not)
✅ **Atribuição**: =, +=, -=, *=, /=, %=, **=, ||=
✅ **Range**: .. (inclusivo), ... (exclusivo)
✅ **Navegação segura**: &. (evita erros com nil)
✅ **Ternário**: condição ? true : false
✅ **Splat**: * (arrays), ** (hashes)
✅ Use parênteses para clareza quando necessário
✅ Muitos operadores são na verdade métodos

## Próximo Passo

Agora que você domina os operadores, vamos aprender sobre **[Estruturas Condicionais](04-estruturas-condicionais.md)** em Ruby!

---

[⬅️ Anterior: Variáveis](02-variaveis.md) | [🏠 Voltar ao Índice](README.md) | [➡️ Próximo: Estruturas Condicionais](04-estruturas-condicionais.md)
